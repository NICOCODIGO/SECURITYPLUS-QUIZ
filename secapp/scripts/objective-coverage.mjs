// Objective coverage for the question bank: how many questions sit under each
// SY0-701 objective, and whether every question carries a valid tag.
//
//   npm run objectives
//
// Exits non-zero when a question has no `objective` or names one that isn't in
// examObjectives.js, so a bad tag is caught the way lint catches a bad import.
//
// A question whose objective belongs to another domain is reported but is not
// an error: plenty of questions are filed in the wrong domain array, which is
// what the "filed elsewhere" summary is for. Moving them is a separate job —
// it changes what each domain quiz asks.

import { readFileSync } from 'node:fs';
import { quizQuestions } from '../src/components/data/quizData.js';
import objectives from '../src/components/data/examObjectives.js';

// securityDomains.js imports PNG icons, which Node can't load, so its weights
// are read as text rather than duplicated here — it stays the source of truth.
const domainsSource = readFileSync(new URL('../src/components/data/securityDomains.js', import.meta.url), 'utf8');
const securityDomains = [...domainsSource.matchAll(
  /id: '(domain\d)',[\s\S]*?number: '([\d.]+)',[\s\S]*?weight: '([^']*)',[\s\S]*?title: '([^']*)'/g
)].map(([, id, number, weight, title]) => ({ id, number, weight, title }));

const THIN = 5; // fewer than this many questions is too thin to practise against

const all = Object.entries(quizQuestions).flatMap(([domainId, list]) =>
  list.map((q, index) => ({ ...q, domainId, index }))
);

const valid = new Map();
for (const [domainId, list] of Object.entries(objectives)) {
  for (const objective of list) valid.set(objective.id, { ...objective, domainId });
}

const problems = [];
const elsewhere = [];
const counts = new Map([...valid.keys()].map((id) => [id, []]));

for (const q of all) {
  const where = `${q.domainId}[${q.index}] ${JSON.stringify(q.question.slice(0, 48))}`;
  if (!q.objective) problems.push(`no objective: ${where}`);
  else if (!valid.has(q.objective)) problems.push(`unknown objective ${q.objective}: ${where}`);
  else {
    counts.get(q.objective).push(q);
    if (valid.get(q.objective).domainId !== q.domainId) elsewhere.push({ q, to: valid.get(q.objective).domainId });
  }
}

const pct = (n) => `${Math.round((n / all.length) * 100)}%`;
console.log(`${all.length} questions across ${valid.size} objectives\n`);

for (const [domainId, list] of Object.entries(objectives)) {
  const total = list.reduce((sum, o) => sum + counts.get(o.id).length, 0);
  console.log(`${domainId}  ${String(total).padStart(3)} questions (${pct(total)})`);
  for (const objective of list) {
    const got = counts.get(objective.id);
    const mix = ['Beginner', 'Intermediate', 'Advanced']
      .map((d) => got.filter((q) => q.difficulty === d).length)
      .join('/');
    const flag = got.length === 0 ? '  <- none' : got.length < THIN ? '  <- thin' : '';
    console.log(`  ${objective.id}  ${String(got.length).padStart(3)}  ${mix.padEnd(9)} ${objective.title.slice(0, 54)}${flag}`);
  }
}

const empty = [...counts].filter(([, got]) => got.length === 0).map(([id]) => id);
const thin = [...counts].filter(([, got]) => got.length > 0 && got.length < THIN).map(([id]) => id);
console.log(`\nno questions (${empty.length}): ${empty.join(', ') || 'none'}`);
console.log(`fewer than ${THIN} (${thin.length}): ${thin.join(', ') || 'none'}`);

// What the domain split looks like as filed, versus by the objective each
// question actually tests, against the real exam weights.
console.log(`\nfiled under a different domain than their objective: ${elsewhere.length} of ${all.length}`);
console.log('domain            filed   by objective   exam weight');
for (const domain of securityDomains) {
  const filed = quizQuestions[domain.id].length;
  const byObjective = objectives[domain.id].reduce((sum, o) => sum + counts.get(o.id).length, 0);
  console.log(
    `  ${domain.number} ${domain.title.slice(0, 14).padEnd(15)}` +
      `${String(filed).padStart(3)} (${pct(filed).padStart(3)})` +
      `${String(byObjective).padStart(7)} (${pct(byObjective).padStart(3)})` +
      `${String(domain.weight).padStart(11)}`
  );
}

if (problems.length) {
  console.error(`\n${problems.length} problem(s):`);
  problems.forEach((p) => console.error('  ' + p));
  process.exit(1);
}
