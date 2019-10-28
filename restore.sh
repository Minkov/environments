
export MSSQL_SA_PASSWORD="Password123"

for backup in /vagrant/dbs; do

db=${backup/.bak/}


sqlcmd -H localhost -U SA -P $MSSQL_SA_PASSWORD -Q "RESTORE DATABASE $db FROM DISK = '/vagrant/dbs/$backup.bak'
WITH MOVE '[$db]' TO '/var/opt/mssql/data/$db.mdf',
MOVE 'WWI_Log' TO '/var/opt/mssql/data/${db}_log.ldf';"

done