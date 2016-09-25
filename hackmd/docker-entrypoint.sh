#!/bin/dash

if [ -f .sequelizerc ];
then
    node_modules/.bin/sequelize db:migrate
fi

# wait for db up
sleep 3

# configure hackmd based on environment variables
node configure.js

# run
NODE_ENV='production' node app.js
