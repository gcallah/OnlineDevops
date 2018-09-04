#!/bin/sh
docker rm devops || true
docker run -it -p 8000:8000 -v $PWD:/home/DevOps devops bash
