#!/bin/sh
export DJANGO_SETTINGS_MODULE=mysite.settings
# must use python notation for path!
export test_dir="devops.tests"

# in case we need to not capture output:
if [ -z $1 ]
then
    export capture=""
else
    export capture="--nocapture"
fi

python3 manage.py test $test_dir.test_integration
