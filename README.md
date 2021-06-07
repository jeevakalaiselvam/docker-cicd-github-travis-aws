# CICD Workflow

## React, Github, Travis, AWS using Docker

### Docker -> React -> Github -> Travis -> AWS

## Command Reference

### Start / Build / Test React application

    npm install     //Install all NPM dependencies
    npm run start   //Start the application
    npm run test    //Run tests for the application
    npm run build   //Generate build for the application

### Build the development image in docker

    //Delete the node_modules folder if you dont need COPY to move them into container every single time

    //Build the docker image using the config details in Dockerfile.dev
    docker build -f Dockerfile.dev .

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

    #Run the multi stage build
    docker build .

    #Run the container exposing the ports
    docker run -p 8080:80 CONTAINER_IMAGE_ID

### Setup integration with Travis CI

    1. Add the Github repository to Travi CI and give access
    2. Create .travis.yml file to help Travis make decisions

    Steps to be configures in TRAVIS
    1. Tell Travis Docker is needed
    2. Build the Docker image using Dockerfile.dev
    3. Tell Travis to run the test suite
    4. If tests are green, Tell travis how to deploy the code to AWS

### Push Code into Github

    1. Commit and Push the new changes to Github
    2. Travis will discover the new commit and initiate a new build
    3. If all configuration are correct, Travis build will exit with exit code 0

### Integration with AWS

    1. Create an account with AWS
    2. Go into the dashboard for Elastic Beanstalk
    3. Create new Application
    4. For Single Docker environment, Use platform as Docker and Amazon 64 bit Linux
    5. Setup Travis CI configuration for linking to AWS
        * Setup Provider Name
        * Setup Region Name
        * Setup App Name
        * Setup Environment Name
        * Setup S3 Bucket Name
        * Setup Key ID and Access Key
