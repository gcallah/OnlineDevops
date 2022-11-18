#!/bin/sh
export USE_MYSQL='True'
export SECRET_KEY='@+%x+r-cfv@*2+qi)&9w^6jvp-h=bypm+7$uee8jlm1%=qvcjw'
export ENGINE='django.db.backends.mysql'
export NAME='devopscourse$devopscourse'
export USER='devopscourse'
export PASSWORD=$DEVOPS_PASSWD
export HOST='devopscourse.mysql.pythonanywhere-services.com'


export utilsdir="utils"

python3 $utilsdir/qexport.py
