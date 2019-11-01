#!/usr/bin/env bash

# Initial

sudo yum -y update

sudo yum -y install vim git yum-utils device-mapper-persistent-data lvm2

# Docker

sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker vagrant

sudo systemctl start docker

# Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

source /vagrant/.env

docker login

# Clone repos

cd /vagrant
git clone https://${GITHUB_USERNAME}:${GITHUB_PASSWORD}@github.com/SoftUni-Internal/interactive-deployment.git
cd /vagrant/interactive-deployment
git pull

# Fireup docker

cd /vagrant/interactive-deployment
docker-compose -f docker-compose.prod.yml up -d

