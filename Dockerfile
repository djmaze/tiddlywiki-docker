FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y software-properties-common curl && \
    curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get install -y nodejs && \
    npm install -g tiddlywiki && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Setup wiki volume
VOLUME /var/lib/tiddlywiki
WORKDIR /var/lib/tiddlywiki

# Add init-and-run script
ADD init-and-run-wiki /usr/local/bin/init-and-run-wiki

# Meta
CMD ["/usr/local/bin/init-and-run-wiki"]
EXPOSE 8080
