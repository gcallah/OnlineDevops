#!/bin/bash

until curl -s dbengine:3306 > /dev/null
do
  >&2 echo "Waiting for MySQL to accept connections"
  sleep 5
done

>&2 echo "Applying database migrations"
# python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json
python manage.py makemigrations
python manage.py migrate
python manage.py loaddata /home/DevOps/datadump.json

>&2 echo "Starting server"
python manage.py runserver 0.0.0.0:8000
