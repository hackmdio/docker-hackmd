FROM node:6.2.2-wheezy
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
	wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - && \
	apt-get update && \
	apt-get install -y git postgresql-client-9.4 && \
	apt-get clean && apt-get purge && rm -r /var/lib/apt/lists/*

# source
RUN mkdir /hackmd
WORKDIR /hackmd
RUN git clone https://github.com/hackmdio/hackmd.git /hackmd

# npm, deps
RUN npm install

# bower
RUN npm install -g bower
RUN bower install --allow-root

# add config
ADD config.json /hackmd/config.json
ADD configure.js /hackmd/configure.js
ADD .sequelizerc /hackmd/.sequelizerc
ADD docker-entrypoint.sh /hackmd/docker-entrypoint.sh

EXPOSE 3000

CMD ["/bin/bash", "/hackmd/docker-entrypoint.sh"]
