#!/usr/bin/env bash

sudo apt-get update

sudo apt-get install -y build-essential dkms linux-image-extra-$(uname -r) linux-headers-$(uname -r)
sudo apt-get install -y virtualbox-guest-additions
sudo apt-get install -y linux-image-generic-lts-raring linux-headers-generic-lts-raring

sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\
> /etc/apt/sources.list.d/docker.list"

sudo apt-get update

sudo apt-get install -y lxc-docker

sudo ufw allow 80/tcp
sudo ufw allow 8080/tcp
