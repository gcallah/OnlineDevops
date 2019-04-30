#!/bin/bash
#Command to delete files older than 5 days

find /home/devopscourse/OnlineDevops/backups/ -mindepth 1 -mtime +5 -delete
