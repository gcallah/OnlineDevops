#!/bin/sh
export HOST_PORT="8000"
if [ $1 ]
then
    HOST_PORT=$1
fi

docker rm devops 2> /dev/null || true 
docker run -it -p $HOST_PORT:8000 -v $PWD:/home/DevOps devops bash