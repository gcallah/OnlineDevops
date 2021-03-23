# specify the base image that contains the basic node setup 
FROM node:alpine 

# setup a working directory 
WORKDIR '/app'

# rebuild the image only when we change package.json,
# don't rebuild the image when we change the source code in index.js

# copy over package.json 
COPY package.json .
# get the dependencies 
RUN npm install 
# copy over the rest of the source code 
COPY . .

# start up the server 
CMD ["npm", "start"]

# use 'docker run redis' to run the redis server  