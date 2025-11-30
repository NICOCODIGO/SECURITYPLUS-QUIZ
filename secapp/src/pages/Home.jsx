import { Card, CardHeader, CardTitle, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Link } from "react-router-dom";

function Home() {
  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Welcome to the Security+ Study Lab</CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          <p>
            Practice Domain-based quizzes, review lessons, and track your progress
            for the SY0-701 exam. We&apos;ll start with mock data, then later hook
            this into your real AWS backend.
          </p>
          <div className="flex gap-3">
            <Button asChild>
              <Link to="/quiz">Start Quiz</Link>
            </Button>
            <Button variant="outline" asChild>
              <Link to="/lessons">Browse Lessons</Link>
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}

export default Home;
