#BUILD PHASE
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Build folder is /app/build

#RUN PHASE
#Start the deployment Phase using NGINX Base image
FROM nginx

#Important config needed for AWS to expose the correct port
EXPOSE 80

#Move the build files into the target serving directory in NGINX
COPY --from=0 /app/build /usr/share/nginx/html 

