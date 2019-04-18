#!/bin/bash
# for the dev server: fetches new code and restarts the server.

git pull origin master
echo "going to reboot the webserver"
touch /var/www/www_thedevopscourse_com_wsgi.py
python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump_mysql1.json
