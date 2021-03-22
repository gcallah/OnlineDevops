# Specify a base image 
# Make sure that image already has node preinstalled on it 
# alpine: image that is as small and compact as possible 
FROM node:alpine 
# project files are now in urs/app directory, rather than the root directory 
WORKDIR /usr/app

# splitting up the COPY step allows us to make changes to our files without 
# re-running npm install 
# make package.json available before we run pm install 
# COPY (package.json from the current working directory) to the (current working dir inside the container)
COPY ./package.json ./
# Install some dependencies 
RUN npm install 
# COPY (everything from the current working directory) to the (current working dir inside the container)
COPY ./ ./
# Set up default command 
# define commands that we want to run when the server is first created 
CMD ["npm", "start"]

# To build an image: docker build . ("." : build context of the current directory)
# to set up port mapping :
# docker run -p 8080:8080 <image id> / <image name>
# docker run -it dennisfench/simpleweb sh to start up the shell inside the container