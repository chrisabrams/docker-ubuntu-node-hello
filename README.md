I created this guide because I wanted to have a docker container on Ubuntu that ran a Node.js server.

Initial problems I ran into before creating this guide:

 - The Docker documentation for this doesn't make much sense, is for a *very* old version of Docker, and uses CentOS.
 - The Docker daemon only works on linux and not OS X - I setup Vagrant for this

# Getting Started
You will need [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed. This guide will show you how to setup a Vagrant instance that uses VirtualBox and then loads Docker inside the Vagrant VM.

## Initialize Vagrant
Run this command from the project's root:

    vagrant up

It will begin loading up the VM; during the initialization, it will ask you which network interface you wish to connect to; make sure to choose one that is exposed to the internet. For me this is typically the `Wi-Fi (AirPort)`.

Once it is done, load the vagrant instance:

    vagrant ssh

If you get an error about Guest Addition versions not matching, first try:

    ls /vagrant

and if you see the contents of this project there, then you're good to go. Vagrant will share the host directory contents that has `Vagrantfile` as `/vagrant` in the VM.

## Modify UFW
Ubuntu's default UFW will drop incoming connections - to fix this

    sudo nano /etc/default/ufw

    # Change:
    # DEFAULT_FORWARD_POLICY="DROP"
    # to
    DEFAULT_FORWARD_POLICY="ACCEPT"

Save the file and then run:

    sudo ufw reload

## Creating a docker container

    cd /vagrant

    sudo docker build -t chrisabrams/ubuntu-node-hello .

This will create a docker container with `chrisabrams` as the username and `ubuntu-node-hello` as the container name. You can rename those to whatever you want. The `.` at the end means take all files in the directory and add them to the container to be built.

## Running a docker container

    sudo docker run -d -p 8080:8080 chrisabrams/ubuntu-node-hello

`-d` will run the container as a daemon.
`-p` will bind port 8080 in docker to port 8080 in the VM.

You should now see `Hello World` when you run:

    curl localhost:8080

## Viewing the docker instance from your OS

    ifconfig

Look for `eth1` and then the `inet addr:`. That should be the network IP address that was assigned to your VM. You can then access that from your browser:

    http://IPADDRESS:8080

## Getting the container's logs

First, view the docker containers:

    sudo docker ps

Find the `CONTAINER_ID` and then run:

    sudo docker logs CONTAINER_ID_HERE

### Additional UFW ports
If you need to open additional ports, add:

    sudo ufw allow 4243/tcp

which would open port `4243`.
