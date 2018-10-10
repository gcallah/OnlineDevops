#!/bin/bash

# migration

echo "Waiting for MySQL to come up"

sleep 90

echo "Apply database migrations"
# python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json
python manage.py makemigrations
python manage.py migrate
python manage.py loaddata /home/DevOps/datadump.json

echo "Starting server"
python manage.py runserver 0.0.0.0:8000
