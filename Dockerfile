FROM ubuntu:14.04

RUN apt-get update

# Install npm
RUN apt-get install -y software-properties-common && apt-get clean
RUN sed -i "s/main/main universe/" /etc/apt/sources.list && add-apt-repository -y ppa:chris-lea/node.js && apt-get update
RUN apt-get install -y nodejs && apt-get clean

# Install tiddlywiki
RUN npm install -g tiddlywiki

# Setup wiki volume
VOLUME /var/lib/tiddlywiki
WORKDIR /var/lib/tiddlywiki

# Meta
CMD tiddlywiki mywiki --init server && tiddlywiki mywiki --server 8080 $:/core/save/all text/plain text/html user "" 0.0.0.0
EXPOSE 8080
