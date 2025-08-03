 TaskFlow 

TaskFlow is a full-stack task management application with a modern UI and secure authentication. Built using **Ruby on Rails API** for the backend and **React (Vite)** for the frontend, TaskFlow helps users manage tasks across three stages: **To Do**, **Doing**, and **Done**.



 Features

 **JWT Authentication** (Register / Login)
 **CRUD Operations** for tasks
 Task columns: **To Do**, **Doing**, **Done**
 User-specific dashboard (only your tasks show)
 Persistent storage via PostgreSQL (or SQLite for dev)
 Backend tests with RSpec + FactoryBot
 Built with Vite + React for blazing-fast frontend



 Tech Stack

 Frontend         | Backend           | Testing         

 React + Vite     | Ruby on Rails API | RSpec            
 React Router DOM | JWT Auth          | FactoryBot       
 Axios            | PostgreSQL/SQLite |                 



 Setup Instructions

 1. Clone the repository

```bash
cd backend
bundle install
rails db:create db:migrate
rails s

git clone https://github.com/YabetsBedluH/TASKFLOW.git
cd TASKFLOW
cd backend
bundle exec rspec

