# DOCKER-VERSION 0.6.6

FROM ubuntu:12.04

# Package up project
ADD . /opt/src

# Install Node.js
RUN apt-get update
RUN apt-get install -y build-essential curl dkms linux-image-extra-$(uname -r) linux-headers-$(uname -r)

RUN mkdir ~/node-install && cd ~/node-install
RUN curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1

RUN mkdir /opt/node

RUN ./configure --prefix=/opt/node && make && make install
RUN echo "export PATH=$PATH:/opt/node/bin" >> ~/.bashrc
RUN source ~/.bashrc

## Install project dependencies
RUN cd /opt/src; npm install

## This allows port 8080 to be seen outside the container
EXPOSE 8080

# Run the node server
CMD ["node", "index.js"]
