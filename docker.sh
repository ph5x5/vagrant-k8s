#!/bin/bash
apt-get update
apt-get -y install apt-transport-https ca-certificates software-properties-common

wget "https://download.docker.com/linux/ubuntu/gpg"
apt-key add - < gpg
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && apt-get update

apt-get -y install docker-ce

systemctl start docker
systemctl enable docker

rm -f gpg
