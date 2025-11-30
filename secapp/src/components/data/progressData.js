const STORAGE_KEY = 'security_plus_progress';

export const getProgress = () => {
  const stored = localStorage.getItem(STORAGE_KEY);
  return stored ? JSON.parse(stored) : [];
};

export const saveProgress = (progress) => {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
};

export const getProgressByLessonId = (lessonId) => {
  const allProgress = getProgress();
  return allProgress.find(p => p.lesson_id === lessonId);
};

export const markLessonComplete = (lessonId, quizScore = null) => {
  const allProgress = getProgress();
  const existingIndex = allProgress.findIndex(p => p.lesson_id === lessonId);
  
  const progressItem = {
    lesson_id: lessonId,
    completed: true,
    completion_date: new Date().toISOString(),
    quiz_score: quizScore,
    time_spent: 0
  };

  if (existingIndex >= 0) {
    allProgress[existingIndex] = { ...allProgress[existingIndex], ...progressItem };
  } else {
    allProgress.push(progressItem);
  }

  saveProgress(allProgress);
  return progressItem;
};

export const updateProgress = (lessonId, updates) => {
  const allProgress = getProgress();
  const existingIndex = allProgress.findIndex(p => p.lesson_id === lessonId);
  
  if (existingIndex >= 0) {
    allProgress[existingIndex] = { ...allProgress[existingIndex], ...updates };
  } else {
    allProgress.push({ lesson_id: lessonId, ...updates });
  }

  saveProgress(allProgress);
};

export const getCompletedLessonsCount = () => {
  const allProgress = getProgress();
  return allProgress.filter(p => p.completed).length;
};

export const getAverageQuizScore = () => {
  const allProgress = getProgress();
  const withScores = allProgress.filter(p => p.quiz_score !== null && p.quiz_score !== undefined);
  
  if (withScores.length === 0) return 0;
  
  const sum = withScores.reduce((acc, p) => acc + p.quiz_score, 0);
  return Math.round(sum / withScores.length);
};

export const getTotalTimeSpent = () => {
  const allProgress = getProgress();
  return allProgress.reduce((acc, p) => acc + (p.time_spent || 0), 0);
};