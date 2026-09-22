// Turns the front end's question bank into a Flyway seed migration.
//
//   node scripts/generate-seed.mjs
//   → server/src/main/resources/db/migration/R__seed_content.sql
//
// The bank lives in JavaScript modules that Node can import directly, so the
// import runs here rather than in Java — parsing JS from the JVM would be the
// wrong tool by a wide margin.
//
// The output is a **repeatable** migration (`R__`), not a versioned one. Flyway
// re-applies a repeatable migration whenever its checksum changes, which is
// exactly right for reference data that keeps being edited: adding a question
// means regenerating this file, not writing V3, V4, V5… Every statement is an
// upsert keyed on a natural key, so re-running it is safe.
//
// Questions that disappear from quizData are marked `retired`, never deleted —
// attempt_answers reference them, and a retired question's history should
// survive.

// `--check` regenerates in memory and compares to the committed file instead of
// writing, so CI fails when someone edits a question and forgets to regenerate.
// A stale seed is invisible otherwise: the app runs, it just serves old content.

import { writeFileSync, readFileSync, existsSync, mkdirSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const data = resolve(root, 'secapp/src/components/data');

// Node's ESM loader rejects a bare Windows absolute path ("c:\...") as an
// unsupported URL scheme, so every dynamic import below goes through file://.
const dataUrl = (file) => pathToFileURL(resolve(data, file)).href;

const { quizQuestions, hashQuestion } = await import(dataUrl('quizData.js'));
const { default: objectives } = await import(dataUrl('examObjectives.js'));

// choiceRationales.js imports its five files without extensions, which Node
// ESM rejects, so the merge is repeated here rather than reused.
const rationales = Object.assign(
  {},
  ...(await Promise.all(
    [1, 2, 3, 4, 5].map((n) => import(dataUrl(`rationales/domain${n}.js`)).then((m) => m.default)),
  )),
);

const OUT = resolve(root, 'server/src/main/resources/db/migration/R__seed_content.sql');

/** A SQL string literal, or NULL. Doubling the quote is the whole escape rule. */
const lit = (value) =>
  value === null || value === undefined ? 'NULL' : `'${String(value).replace(/'/g, "''")}'`;

const domainNumber = (domainId) => Number(domainId.replace('domain', ''));

const out = [];
const w = (line = '') => out.push(line);

w('-- GENERATED FILE — DO NOT EDIT BY HAND.');
w('-- Regenerate with:  node scripts/generate-seed.mjs');
w('--');
w('-- Repeatable migration: Flyway re-applies it whenever the checksum changes,');
w('-- so editing a question means regenerating this file, not adding a new V<n>.');
w('-- Every statement is an upsert, so re-running it is safe.');
w();

/* ---------------------------------------------------------- objectives -- */

const objectiveRows = [];
for (const [domainId, list] of Object.entries(objectives)) {
  for (const objective of list) {
    objectiveRows.push({
      code: objective.id,
      domain: domainNumber(domainId),
      title: objective.title,
    });
  }
}

w(`-- ${objectiveRows.length} objectives`);
w('insert into objectives (code, domain_number, title) values');
w(
  objectiveRows
    .map((o) => `  (${lit(o.code)}, ${o.domain}, ${lit(o.title)})`)
    .join(',\n'),
);
w('on conflict (code) do update set');
w('  domain_number = excluded.domain_number,');
w('  title         = excluded.title;');
w();

/* ----------------------------------------------------------- questions -- */

const valid = new Set(objectiveRows.map((o) => o.code));
const questions = [];
const problems = [];

for (const [domainId, list] of Object.entries(quizQuestions)) {
  for (const [index, q] of list.entries()) {
    const where = `${domainId}[${index}] ${JSON.stringify(q.question.slice(0, 48))}`;

    if (!q.objective) problems.push(`no objective: ${where}`);
    else if (!valid.has(q.objective)) problems.push(`unknown objective ${q.objective}: ${where}`);
    if (!Array.isArray(q.choices) || q.choices.length < 2) problems.push(`too few choices: ${where}`);
    if (typeof q.correctAnswer !== 'number' || !q.choices?.[q.correctAnswer]) {
      problems.push(`correctAnswer out of range: ${where}`);
    }

    questions.push({ ...q, filedDomain: domainNumber(domainId), hash: hashQuestion(q.question) });
  }
}

// A duplicate hash means two questions share identical text, which would break
// the unique key and silently merge their history.
const seen = new Map();
for (const q of questions) {
  if (seen.has(q.hash)) problems.push(`duplicate question text: ${JSON.stringify(q.question.slice(0, 60))}`);
  seen.set(q.hash, q);
}

if (problems.length > 0) {
  console.error(`Refusing to generate — ${problems.length} problem(s) in the question bank:`);
  for (const p of problems) console.error(`  ${p}`);
  process.exit(1);
}

w(`-- ${questions.length} questions`);
for (const q of questions) {
  w(
    'insert into questions (legacy_hash, text, difficulty, objective_code, filed_domain, explanation, status) values',
  );
  w(
    `  (${lit(q.hash)}, ${lit(q.question)}, ${lit(q.difficulty)}, ${lit(q.objective)}, ${q.filedDomain}, ${lit(q.explanation)}, 'published')`,
  );
  w('on conflict (legacy_hash) do update set');
  w('  text = excluded.text, difficulty = excluded.difficulty,');
  w('  objective_code = excluded.objective_code, filed_domain = excluded.filed_domain,');
  w("  explanation = excluded.explanation, status = 'published', updated_at = now();");
}
w();

/* ------------------------------------------------------------- choices -- */

let choiceCount = 0;
let rationaleCount = 0;
let missingRationales = 0;

w('-- choices, joined to their question by legacy_hash');
for (const q of questions) {
  for (const [position, text] of q.choices.entries()) {
    const isCorrect = position === q.correctAnswer;
    const rationale = isCorrect ? null : (rationales[q.question]?.[text] ?? null);

    if (!isCorrect) {
      if (rationale) rationaleCount += 1;
      else missingRationales += 1;
    }
    choiceCount += 1;

    w('insert into choices (question_id, position, text, is_correct, rationale)');
    w(
      `select q.id, ${position}, ${lit(text)}, ${isCorrect}, ${lit(rationale)} from questions q where q.legacy_hash = ${lit(q.hash)}`,
    );
    w('on conflict (question_id, position) do update set');
    w('  text = excluded.text, is_correct = excluded.is_correct, rationale = excluded.rationale;');
  }
}
w();

/* ------------------------------------------------------------- retired -- */

w('-- Anything no longer in the bank is retired, never deleted: attempt_answers');
w('-- reference these rows, and a retired question keeps its history.');
w("update questions set status = 'retired', updated_at = now()");
w("where status <> 'retired' and legacy_hash not in (");
w(questions.map((q) => `  ${lit(q.hash)}`).join(',\n'));
w(');');
w();

const sql = `${out.join('\n')}\n`;
const relative = OUT.replace(`${root}/`, '');

if (process.argv.includes('--check')) {
  if (!existsSync(OUT)) {
    console.error(`${relative} is missing. Generate it with:  node scripts/generate-seed.mjs`);
    process.exit(1);
  }
  if (readFileSync(OUT, 'utf8') !== sql) {
    console.error(`${relative} is stale — the question bank has changed since it was generated.`);
    console.error('Regenerate with:  node scripts/generate-seed.mjs');
    process.exit(1);
  }
  console.log(`Seed OK — ${relative} matches the question bank.`);
  process.exit(0);
}

mkdirSync(dirname(OUT), { recursive: true });
writeFileSync(OUT, sql);

const kb = (Buffer.byteLength(sql) / 1024).toFixed(0);
console.log(`Wrote ${relative} (${kb}KB)`);
console.log(
  `  ${objectiveRows.length} objectives, ${questions.length} questions, ${choiceCount} choices`,
);
console.log(`  ${rationaleCount} wrong-choice rationales, ${missingRationales} missing`);

if (missingRationales > 0) {
  console.log('\nMissing rationales are seeded as NULL — the content test is what fails on them.');
}
