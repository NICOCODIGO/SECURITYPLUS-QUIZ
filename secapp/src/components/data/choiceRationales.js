// Why each wrong choice is wrong — the counterpart to a question's single
// `explanation`, which only says why the right answer is right.
//
// One file per domain in ./rationales, mirroring quizQuestions. Entries are
// keyed by question text, then by the wrong choice's text, rather than by
// index: they read on their own when reviewing, and survive the choices
// being reordered. Edit a question's wording in quizData and its entry here
// must be renamed to match, or the question simply shows no "why not" line.

import domain1 from './rationales/domain1';
import domain2 from './rationales/domain2';
import domain3 from './rationales/domain3';
import domain4 from './rationales/domain4';
import domain5 from './rationales/domain5';

const rationales = { ...domain1, ...domain2, ...domain3, ...domain4, ...domain5 };

/** The rationale for one wrong choice, or null if none is written. */
export const getChoiceRationale = (question, choiceIndex) => {
  if (!question || choiceIndex === question.correctAnswer) return null;
  return rationales[question.question]?.[question.choices[choiceIndex]] ?? null;
};
