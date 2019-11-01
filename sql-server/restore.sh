#!/usr/bin/env bash

sudo cp /vagrant/backups/* /var/opt/mssql/data/

# BACKUP_DIR=/home/doncho/repos/sqlserver-automation/*
BACKUP_DIR=/vagrant/backups/*

# chown -R vagrant:vagrant /vagrant/backups/

for BACKUP_FILE_PATH in $BACKUP_DIR; do

BACKUP_FILE=$(basename "$BACKUP_FILE_PATH")
DB_NAME=${BACKUP_FILE/.bak/}

QUERY="RESTORE DATABASE [$DB_NAME] FROM DISK = N'/var/opt/mssql/data/${BACKUP_FILE}' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5"
sqlcmd -H localhost -U SA -P Password123 -Q "$QUERY"

done