import { lessons } from "@/components/data/lessonsData.js";
import LessonCard from "@/components/lessons/LessonCard.jsx";

function Lessons() {
  return (
    <div className="space-y-4">
      <h1 className="text-2xl font-semibold mb-4">Lessons</h1>
      <div className="grid gap-4 md:grid-cols-2">
        {lessons.map((lesson) => (
          <LessonCard key={lesson.id} lesson={lesson} />
        ))}
      </div>
    </div>
  );
}

export default Lessons;
