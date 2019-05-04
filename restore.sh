#!/bin/bash
#This file is to restore the database
#It takes the name of the file to restore as command line argument
#The Dated backups of data is in OnlineDevops/backups folder
#To run this script ./restore.sh backups/filename.json

export USE_MYSQL= false
export NAME='db.sqlite3'
export ENGINE='django.db.backends.sqlite3'

if [[ -z "$1" ]]
then
    echo "Usage restore.sh <filetoload> <optional:use_mysql>"
    exit 1
fi
echo "USE_MYSQL =$USE_MYSQL"
# exit 0

restore_file="$1"

if [[ -z "$2" ]]
then
    echo "Second parameter is for controlling which db to use."
fi

restore_file="$1"

python3 manage.py loaddata $restore_file

git commit -m 'Daily Database BackUp' db.sqlite3
git push origin master
