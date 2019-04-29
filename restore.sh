#!/bin/bash
#This file is to restore the database
#It takes the name of the file to restore as command line argument
#The Dated backups of data is in OnlineDevops/backups folder
#To run this script ./restore.sh backups/filename.json

export USE_MYSQL=""
if [[ -z "$1" ]]
then
    echo "Usage restore.sh <filetoload> <optional:use_mysql>"
    exit 1
fi

restore_file="$1"

if [[ -z "$2" ]]
then
    # use mysql turned on here
fi

restore_file="$1"

python manage.py loaddata $restore_file

git commit db.sqlite3
git push origin master
