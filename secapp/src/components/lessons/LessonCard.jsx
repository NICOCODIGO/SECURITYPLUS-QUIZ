import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Link } from "react-router-dom";

function LessonCard({ lesson }) {
  return (
    <Card className="flex flex-col h-full">
      <CardHeader>
        <CardTitle className="flex justify-between items-center gap-2">
          <span>{lesson.title}</span>
          <Badge variant="outline">Domain {lesson.domain}</Badge>
        </CardTitle>
      </CardHeader>
      <CardContent className="mt-auto flex justify-between items-center">
        <span className="text-sm text-slate-400">
          {lesson.estimatedMinutes} min • {lesson.difficulty}
        </span>
        <Link
          to={`/lessons/${lesson.id}`}
          className="text-sm text-blue-400 hover:underline"
        >
          View
        </Link>
      </CardContent>
    </Card>
  );
}

export default LessonCard;
