#!/bin/sh

if [ "$HMD_DB_URL" = "" ]; then
    HMD_DB_URL="postgres://hackmd:hackmdpass@hackmdPostgres:5432/hackmd"
fi

DB_SOCKET=$(echo ${HMD_DB_URL} | sed -e 's/.*:\/\//\/\//' -e 's/.*\/\/[^@]*@//' -e 's/\/.*$//')

echo $HMD_DB_URL

echo $DB_SOCKET

if [ "DB_SOCKET" != "" ]; then
    dockerize -wait tcp://${DB_SOCKET} -timeout 30s
fi

node_modules/.bin/sequelize db:migrate

# Print warning if local data storage is used but no volume is mounted
[ "$HMD_IMAGE_UPLOAD_TYPE" = "filesystem" ] && { mountpoint -q ./public/uploads || {
    echo "
        #################################################################
        ###                                                           ###
        ###                        !!!WARNING!!!                      ###
        ###                                                           ###
        ###        Using local uploads without persistence is         ###
        ###            dangerous. You'll loose your data on           ###
        ###              container removal. Check out:                ###
        ###  https://docs.docker.com/engine/tutorials/dockervolumes/  ###
        ###                                                           ###
        ###                       !!!WARNING!!!                       ###
        ###                                                           ###
        #################################################################
    ";
} ; }

# Sleep to make sure everything is fine...
sleep 3

# run
node app.js

