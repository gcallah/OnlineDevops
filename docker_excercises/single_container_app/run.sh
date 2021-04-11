#!/bin/bash

docker build .
read -p "Enter Your Docker ID: " ID 
docker run -p 8080:8080 $ID
