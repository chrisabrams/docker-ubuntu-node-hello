I created this guide because I wanted to have a docker container on Ubuntu that ran a Node.js server.

Initial problems I ran into before creating this guide:

 - The Docker documentation for this doesn't make much sense, is for a *very* old version of Docker, and uses CentOS.
 - The Docker daemon only works on linux and not OS X - I setup Vagrant for this

# Getting Started
You will need [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed. This guide will show you how to setup a Vagrant instance that uses VirtualBox and then loads Docker inside the Vagrant VM.

## Initialize Vagrant
Run this command from the project's root:

    vagrant up

Load the vagrant instance

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

### Additional UFW ports
If you need to open additional ports, add:

    sudo ufw allow 4243/tcp

which would open port `4243`.
