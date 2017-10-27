FROM node:6.11.5-alpine

# Build arguments to change source url, branch or tag
ARG HACKMD_REPOSITORY=https://github.com/hackmdio/hackmd.git
ARG VERSION=master

# Set some default config variables
ENV DOCKERIZE_VERSION=v0.3.0
ENV NODE_ENV=production

RUN apk add --no-cache --virtual .download wget  ca-certificates && \
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    apk del .download

# Add configuraton files
COPY config.json .sequelizerc /files/

# Install all dependencies and build project
RUN apk add --no-cache --virtual .dep build-base python git bash && \
    # Clone the source
    git clone --depth 1 --branch $VERSION $HACKMD_REPOSITORY /hackmd && \
    # Print the cloned version and clean up git files
    cd /hackmd && \
    git log --pretty=format:'%ad %h %d' --abbrev-commit --date=short -1 && echo && \
    rm -rf /hackmd/.git && \
    # Symlink configuration files
    rm -f /hackmd/config.json && ln -s /files/config.json /hackmd/config.json && \
    rm -f /hackmd/.sequelizerc && ln -s /files/.sequelizerc /hackmd/.sequelizerc && \
    # Install NPM dependencies and build project
    yarn install && \
    yarn install --production=false && \
    yarn global add webpack && \
    npm run build && \
    # Clean up this layer
    npm prune --production && \
    apk del .dep && \
    adduser -u 10000 -h /hackmd/ -D -S hackmd && \
    chown -R hackmd /hackmd/

WORKDIR /hackmd
EXPOSE 3000
USER hackmd

# Add entrypoint and set command
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
