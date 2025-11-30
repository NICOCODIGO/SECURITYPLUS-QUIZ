import { Routes, Route } from "react-router-dom";
import Layout from "./Layout.jsx";
import Home from "@/pages/Home.jsx";
import Lessons from "@/pages/Lessons.jsx";
import LessonDetail from "@/pages/LessonDetail.jsx";
import TakeQuiz from "@/pages/TakeQuiz.jsx";
import Progress from "@/pages/Progress.jsx";
import AboutCertification from "@/pages/AboutCertification.jsx";
import AdminContentManager from "@/pages/AdminContentManager.jsx";

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Home />} />
        <Route path="lessons" element={<Lessons />} />
        <Route path="lessons/:lessonId" element={<LessonDetail />} />
        <Route path="quiz" element={<TakeQuiz />} />
        <Route path="progress" element={<Progress />} />
        <Route path="about-certification" element={<AboutCertification />} />
        <Route path="admin" element={<AdminContentManager />} />
      </Route>
    </Routes>
  );
}

export default App;
