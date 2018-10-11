#!/usr/bin/env bash
mysql -u root -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < dbcreation.sql;
