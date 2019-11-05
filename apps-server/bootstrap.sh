#!/usr/bin/env bash

# Initial

source /vagrant/.env

echo ' --- Updating packages ---'
sudo yum -y update > /dev/null

echo ' --- Installing vim git yum-utils device-mapper-persistent-data lvm2 ---'
sudo yum -y install vim git yum-utils device-mapper-persistent-data lvm2 > /dev/null

# Docker

echo ' --- Remove old docker packages if existing ---'
sudo yum remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-engine > /dev/null

echo '--- Adding docker repo ---'
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo > /dev/null

echo ' --- Installing docker ---'
sudo yum install -y docker-ce docker-ce-cli containerd.io > /dev/null

sudo usermod -aG docker vagrant

sudo systemctl start docker

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin

# Docker Compose

if ! [ -x "$(command -v docker-compose)" ]; then
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi

# Fireup docker

cd /vagrant/apps
docker-compose -f docker-compose.${ENVIRONMENT}.yml pull
docker-compose -f docker-compose.${ENVIRONMENT}.yml up -d

