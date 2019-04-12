#!/bin/bash
# This shell file deploys a new version to our server.

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 .travis/id_rsa # Allow read access to the private key
ssh-add .travis/id_rsa # Add the private key to SSH

echo "SSHing to PythonAnywhere."
ssh devopscourse@ssh.pythonanywhere.com << EOF
    cd /home/devopscourse/OnlineDevops
    /home/devopscourse/OnlineDevops/rebuild.sh
EOF
