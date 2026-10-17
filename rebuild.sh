#!/bin/bash
# for the prod server: fetches new code and restarts the server.
# (The GitHub deploy workflow also reloads the web app via the
# PythonAnywhere API, since touching the WSGI file no longer does.)

# fail the deploy, rather than silently serving old code, if the pull fails
git pull origin master || exit 1
echo "going to reboot the webserver"
touch /var/www/www_thedevopscourse_com_wsgi.py
