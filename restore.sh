#!/bin/bash
#This file is to restore the database
#It takes the name of the file to restore as command line argument
#The Dated backups of data is in OnlineDevops/backups folder
#To run this script ./restore.sh backups/filename.json

#export USE_MYSQL=""
restore_file="$1"
python manage.py loaddata $restore_file
