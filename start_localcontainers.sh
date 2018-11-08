#!/bin/bash

python3 manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json

if [ $# -eq 0 ]
then
  docker-compose up
else
  docker-compose up $@
fi
