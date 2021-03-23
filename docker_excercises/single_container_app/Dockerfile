# specify a base image 
# note: make sure that the image already has node pre-installed on it 
# alpine: image that is as small and compact as possible 
FROM node:alpine 
# set the project directory, the dafault directiry will be the root directory
WORKDIR /usr/app

# splitting up the COPY step allows us to make changes to index.js without 
# re-running npm install 
# making package.json available before we run npm install 
# COPY (from current working dir) to (current working dir inside the container)
COPY ./package.json ./
# install some dependencies 
RUN npm install 
# COPY (everything from current working dir) to (current working dir inside the container)
COPY ./ ./
# define commands that we want to run when the server is first created 
CMD ["npm", "start"]

# To build an image: docker build . ("." : build context of the current directory)
# to set up port mapping
    # docker run -p 8080:8080 <image id> / <image name>