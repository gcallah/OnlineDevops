#!/bin/bash
# for the prod server: fetches new code and restarts the server.

git pull origin master
echo "going to reboot the webserver"
touch /var/www/www_thedevopscourse_com_wsgi.py
