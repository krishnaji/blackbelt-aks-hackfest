#!/bin/bash

echo "Installing Mongo DB"
sudo sh -c 'echo -e "[mongodb-org-3.6]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc" > /etc/mongod.conf'
sudo yum install -y mongodb-org

#Change mongo port
sed -i -e 's/270179/270917/g' /etc/mongod.conf
systemctl start mongod

echo "Mongo install complete"

echo "Installing Azure CLI"
rpm --import https://packages.microsoft.com/keys/microsoft.asc

sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

yum install -y azure-cli-2.0.23-1.el7
echo "Done installing Azure CLI"

echo "Installing Docker"
yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce

systemctl start docker
echo "Done Installing Docker"

echo "Installing Git"
yum install -y git
echo "Git installed"

echo "Install NodeJS"
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
yum -y install nodejs
echo "Done installing NodeJS"