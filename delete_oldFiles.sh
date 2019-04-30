#!/bin/bash
#Command to delete files older than 5 days

#Command to print the files that will be deleted
find /home/devopscourse/OnlineDevops/backups/ -mindepth 1 -mtime +5 -depth -print

#Command to delete files
find /home/devopscourse/OnlineDevops/backups/ -mindepth 1 -mtime +5 -delete
