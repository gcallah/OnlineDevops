#!/bin/sh
docker rm devops 2> /dev/null || true 
docker run -it -p 8000:8000 -v $PWD:/home/DevOps devops bash
