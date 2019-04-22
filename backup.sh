#!/bin/bash
# Backs up our database in json format.
export USE_MYSQL=1
export backup_dir=backups
export backup_file=$backup_dir/dbbackup_$(date +\%m-\%d-\%Y-\%H:\%M:\%S).json

python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > $backup_file
