Day 1: Startup

This is my second attempt at building this project. I originally tried to create a Security+ study guide website a while back, but halfway through I scrapped it. I ran into constant frustration, misconfigurations, a messy file tree, too many redesigns, and no clear plan to stick to. It felt like the project was falling apart faster than I could fix it.

But that first failed attempt taught me a lot.
Now I’m approaching this version differently: with better planning, a clean structure, clearer goals, and the discipline to stay consistent. I want to build something real, a website that students cann use to to help them prepare the Security+ exam, a real helpfull website! 

This time, it’s not just about coding. It’s about learning how to build a project from the ground up the right way.

So far what I have done: 

Initialized a new React project using Vite

Installed required libraries:

React Router

Tailwind CSS v3

shadcn/ui

lucide-react

react-markdown

Added jsconfig.json and Vite alias for @/ imports

Converted all config files to .cjs to work with "type": "module"
Added Tailwind directives in src/index.css:

I created a professional-level folder structure to separate pages, UI components, mock data, and future AWS logic:
![alt text](image.png)
![alt text](image-1.png)

Core Features I have implemented:

Global layout with navigation

Working routing system

Home page with CTA buttons

Lessons page that loads mock lessons

LessonCard UI component using shadcn/ui

Scroll-to-top handler for route changes

Tailwind + theme tokens working properly

Mock data replacing real AWS calls (for now)

Also some of the issues I ran into:

Tailwind v4 installed by mistake (shadcn needs Tailwind v3)

Missing Tailwind config in project root

Need to rename config files to .cjs because package.json uses "type": "module"

Vite couldn’t load postcss.config.js

Vite couldn't find Tailwind because config file was incorrect extension

Failed import paths due to missing @ alias

Needed to add alias to vite.config.js and jsconfig.json

Component folders existed but files were missing

Missing shadcn UI components (badge, card, button)

Incorrect file paths after rebuilding front-end

Restarting dev server required after config changes

For the next step Ill have to build a full quiz interface using mock quizData, create a PBQ or scenerio-based question UI, adding progress, tracking, and my biggest goal is to connect it all to the backend with AWS!

