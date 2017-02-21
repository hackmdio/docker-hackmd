FROM node:boron
ENV DEBIAN_FRONTEND noninteractive
ENV HACKMD_VERSION 0.5.0
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
	wget -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - && \
	apt-get update && \
	apt-get install -y git postgresql-client-9.6 build-essential

# source
RUN mkdir /hackmd
WORKDIR /hackmd
RUN git clone --branch ${HACKMD_VERSION:-master} --depth 1 https://github.com/hackmdio/hackmd.git /hackmd

# npm, deps
RUN npm install

# add config
ADD config.js /hackmd/public/js/config.js
ADD config.json /hackmd/config.json
ADD .sequelizerc /hackmd/.sequelizerc
ADD docker-entrypoint.sh /hackmd/docker-entrypoint.sh

# build front-end bundle
RUN npm run build

# remove dev dependencies
RUN npm prune --production

# remove build dependencies
RUN apt-get remove -y --auto-remove build-essential && \
	apt-get clean && apt-get purge && rm -r /var/lib/apt/lists/*

EXPOSE 3000

CMD ["/bin/bash", "/hackmd/docker-entrypoint.sh"]
