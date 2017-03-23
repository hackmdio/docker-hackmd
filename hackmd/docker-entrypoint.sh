#!/bin/bash

if [ -f .sequelizerc ];
then
    node_modules/.bin/sequelize db:migrate
fi

# Print warning if local data storage is used but no volume is mounted
[ "$HMD_IMAGE_UPLOAD_TYPE" = "filesystem" ] && { mountpoint -q ./public/uploads || {
    echo "
        #################################################################
        ###                                                           ###
        ###                         !!!WARNING!!!                     ###
        ###                                                           ###
        ###        Using local uploads without persistence is         ###
        ###            dangerous. You'll loose your data on           ###
        ###              container removal. Check out:                ###
        ###  https://docs.docker.com/engine/tutorials/dockervolumes/  ###
        ###                                                           ###
        ###                          !!!WARNING!!!                    ###
        ###                                                           ###
        ##################################################################
        
    ";
} ; }

# wait for db up
sleep 3

# configure hackmd based on environment variables
node configure.js

# run
NODE_ENV='production' node app.js
