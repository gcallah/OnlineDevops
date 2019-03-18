#!/bin/sh
export HOST_PORT="8000"
export REPO="onlinedevops"
export DH_ACCOUNT="gcallah"
export CONTAINER="$DH_ACCOUNT/$REPO-dev"
if [ $1 ]
then
    HOST_PORT=$1
fi

docker rm devops 2> /dev/null || true 
docker run -it -p $HOST_PORT:8000 -v $PWD:/home/$REPO $CONTAINER bash
