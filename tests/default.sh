#!/bin/sh
echo "
         ######################################
         ###          Default test           ##
         ######################################
"


# Make sure tests fails if a commend ends without 0
set -e

# Generate some random ports for testing
PORT=$(cat /dev/urandom|od -N2 -An -i|awk -v f=10000 -v r=19999 '{printf "%i\n", f + r * $1 / 65536}')


# Make sure the ports are not already in use. In case they are rerun the script to get new ports.
[ $(netstat -an | grep LISTEN | grep :$PORT | wc -l) -eq 0 ] || { ./$0 && exit 0 || exit 1; }

# Run container in a simple way
DOCKERCONTAINER=$(docker run -d -p 127.0.0.1:${PORT}:3000 -e POSTGRES_USER=hackmd -e POSTGRES_PASSWORD=hackmdpass --link hackmd-database:hackmdPostgres hackmd:testing)

# Make sure the container is not restarting
sleep 40
docker ps -f id=${DOCKERCONTAINER}


wget -O- http://127.0.0.1:${PORT}/

docker logs ${DOCKERCONTAINER}

sleep 20
docker ps -f id=${DOCKERCONTAINER}

# Clean up
docker stop ${DOCKERCONTAINER} && docker rm ${DOCKERCONTAINER}
