#!/usr/bin/env bash
# Part of Vagrant virtual environments for SQL Server 2017 on Ubuntu Linux
#
# Setup environment configuration
export ACCEPT_EULA="Y"
export MSSQL_PID="Developer"
export MSSQL_SA_PASSWORD="1qwe-qweqweASDASd345Qwe"
export DEBIAN_FRONTEND="noninteractive"

sudo apt-get -y update

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
sudo apt-get update
sudo apt-get install -y mssql-server

sudo apt-get -y -q autoremove
sudo apt-get -y -q clean

echo "SQLServer: running /opt/mssql/bin/mssql-conf -n setup"
echo "SQLServer: MSSQL_PID=$MSSQL_PID"
echo "SQLServer: MSSQL_SA_PASSWORD=$MSSQL_SA_PASSWORD"

sudo -E bash -c '/opt/mssql/bin/mssql-conf -n setup'
sudo /opt/mssql/bin/mssql-conf set telemetry.customerfeedback false

echo "SQLServer: restarting"
sudo systemctl stop mssql-server
sudo systemctl start mssql-server
sudo systemctl status mssql-server

echo "SQLServer: Guest IP address:"
ip addr show|grep -w inet
echo "Bootstrap: DONE"