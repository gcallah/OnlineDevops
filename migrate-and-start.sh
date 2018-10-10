#!/bin/bash

# migration

echo "Apply database migrations"

# python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json
# exec python /home/DevOps/manage.py makemigrations
# exec python /home/DevOps/manage.py migrate
# exec python /home/DevOps/manage.py loaddata /home/DevOps/datadump.json

echo "Starting server"
exec python /home/DevOps/manage.py runserver 0.0.0.0:8000
