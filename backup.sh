#!/bin/bash
# Backs up our database.
export USE_MYSQL=1
export backup_dir=backups
export backup_file=$backup_dir/dbbackup.json

python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > $backup_file
