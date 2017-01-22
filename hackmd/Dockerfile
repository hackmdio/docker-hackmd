FROM node:boron

ARG VERSION=master

ENV DEBIAN_FRONTEND noninteractive

# Add files
ADD config.js /files/config.js
ADD config.json /files/config.json
ADD .sequelizerc /files/.sequelizerc


RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y git postgresql-client-9.6 build-essential && \
#       Add Source
        git clone https://github.com/hackmdio/hackmd.git -b $VERSION /hackmd && \
    cd /hackmd && \
    rm -f /hackmd/public/js/config.js && ln -s /files/config.js /hackmd/public/js/config.js && \
    rm -f /hackmd/config.json && ln -s /files/config.json /hackmd/config.json && \
    rm -f /hackmd/.sequelizerc && ln -s /files/.sequelizerc /hackmd/.sequelizerc && \

#   Install dependencies
    npm install && \
    npm run build:prod && \
#   Clean up image
    npm prune --production && \
    apt-get remove -y --auto-remove build-essential && \
    apt-get clean && apt-get purge && rm -r /var/lib/apt/lists/* && \
    adduser -uid 10000 --home /hackmd/ --disabled-login --system hackmd && \
    chown -R hackmd /hackmd/

ADD docker-entrypoint.sh /hackmd/docker-entrypoint.sh

WORKDIR /hackmd

EXPOSE 3000

USER hackmd

ENTRYPOINT ["/hackmd/docker-entrypoint.sh"]
