#!/bin/bash

docker exec -it devopsapp bash -c 'python manage.py makemigrations && python manage.py migrate && python manage.py loaddata datadump.json && python manage.py runserver 0.0.0.0:8000'
