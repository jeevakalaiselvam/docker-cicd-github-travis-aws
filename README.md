# CICD Workflow with React, Github, Travis, AWS using Docker

## This is a simple CICD workflow with Docker

### React -> Github -> Travis -> AWS

## Command Reference

### Start / Build / Test React application

    npm install     //Install all NPM dependencies
    npm run start   //Start the application
    npm run test    //Run tests for the application
    npm run build   //Generate build for the application

### Build the development image in docker

    docker build -f Dockerfile.dev .
    //Delete the node_modules folder if you dont need COPY to move them into container every single time

### Run the container

    //Map port 3000 in host to port 3000 in the container with id CONTAINER_IMAGE_ID
    docker run -p 3000:3000 CONTAINER_IMAGE_ID

### Volume mapping to reflect changes in source for each build

    //Map all files and folders in current working directory to the /app folder in container with id CONTAINER_IMAGE_ID
    docker run -p 3000:3000 -v /app/node_modules -v $(pwd):/app CONTAINER_IMAGE_ID

### Simplify build process with Docker Compose

    //First create the docker-compose.yml file and add configuration details

     //Bring up the containers
    docker-compose up

    //Build the containers and  bring them up to reflect recent changes
    docker-compose up --build

### Run the test suite inside the container

    #Build the container
    docker build -f Dockerfile.dev .

    #Use the container image to get a interactive shell
    docker run -it CONTAINER_IMAGE npm run test

    #Listening to Test Suite on already built container
    docker-compose up
    docker ps #Grab the container image from here
    docker run -it CONTAINER_IMAGE npm run test

    #Using services in docker-compose.yml to configure and listen for Test Suite
    docker-compose up --build
    docker container ls //To check the new containers running

### Creating Production Version for the React Application

    #Application needs PROD SERVER to serve production bundled application build
    #Create Dockerfile for production with multi step build process
    #Copy the build directory from running npm run build into the static content serve directory of nginx server
    #The path to serve static content in nginx is /usr/share/nginx/html
