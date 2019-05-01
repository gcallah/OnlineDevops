#!/bin/sh
export DJANGO_SETTINGS_MODULE=mysite.settings
export test_dir="devops/tests"

# in case we need to not capture output:
if [ -z $1 ]
then
    export capture=""
else
    export capture="--nocapture"
fi

nosetests $test_dir/test_integration.py
