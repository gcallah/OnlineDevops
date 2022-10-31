#!/bin/bash
# This shell file deploys a new version to our server.

if [ -z "$PA_PWD" ]
then
    echo "The PythonAnywhere password var (PA_PWD) must be set in the env."
    exit 1
fi

echo "SSHing to PythonAnywhere."
sshpass -p $PA_PWD ssh -o "StrictHostKeyChecking no" devopscourse@ssh.pythonanywhere.com << EOF
    cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh
EOF
