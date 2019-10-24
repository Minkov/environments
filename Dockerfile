RUN apt-get -y update

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

RUN sudo add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/msprod.list

RUN sudo apt-get update
RUN sudo apt-get install -y mssql-server
RUN sudo apt-get install -y mssql-tools unixodbc-dev

RUN 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile

RUN /opt/mssql/bin/mssql-conf -n setup

RUN ip addr show|grep -w inet