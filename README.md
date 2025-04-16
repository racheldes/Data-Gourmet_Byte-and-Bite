# Spring 2025 CS 3200 Project Template Repository

This repo is our semester project. It includes the 3 containers: API, APP, and database containers. This is for an application of a meal plan and recipe sharing app. Four user personas organized our blueprints and routes: User, nutritionist, data analyst, and app manager.
## Project Demo Video
https://www.youtube.com/watch?v=qvIV4IEBIDs 

## Prerequisites

- A GitHub Account
- A terminal-based git client or GUI Git client such as GitHub Desktop or the Git plugin for VSCode.
- VSCode with the Python Plugin
- A distribution of Python running on your laptop. The distro supported by the course is Anaconda or Miniconda.


## Current Project Components

Currently, there are three major components that will each run in their own Docker Containers:

- Streamlit App in the ./app directory
- Flask REST api in the ./api directory
- MySQL Database that will be initialized with SQL script files from the ./database-files directory

### Setting Up Your Personal Repo

1. Set up the .env file in the api folder based on the .env.template file.  Ensure that the database name reflects ByteBite and that the password is customized to for your personal use. 
2. For running the testing containers (for your team's repo):
   1. docker compose up -d to start all the containers in the background
   2. docker compose down to shutdown and delete the containers
   3. docker compose up db -d only start the database container (replace db with api or app for the other two services as needed)
3. docker compose stop to "turn off" the containers but not delete them.

### Group Member Names 
- Rachel Des Bordes 
- Britney Bah
- Mckenzie Wright
- Yazmin Alvarado
