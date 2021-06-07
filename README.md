# CICD Workflow with React, Github, Travis, AWS using Docker

## This is a simple CICD workflow with Docker

### React -> Github -> Travis -> AWS

## Command Reference

### Start / Build / Test React application

    npm run start //Start the application
    npm run test //Run tests for the application
    npm run build //Generate build for the application

### Build the development image in docker

    docker build -f Dockerfile.dev .
