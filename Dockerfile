#BUILD PHASE
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run BUILD

#Build folder is /app/build

#RUN PHASE
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html 

