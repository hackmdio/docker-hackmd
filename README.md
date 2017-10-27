[![](https://images.microbadger.com/badges/version/hackmdio/hackmd.svg)](https://microbadger.com/images/hackmdio/hackmd "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/hackmdio/hackmd.svg)](https://microbadger.com/images/hackmdio/hackmd "Get your own image badge on microbadger.com")

[![](https://images.microbadger.com/badges/version/hackmdio/hackmd:lite.svg)](https://microbadger.com/images/hackmdio/hackmd:lite "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/hackmdio/hackmd:lite.svg)](https://microbadger.com/images/hackmdio/hackmd:lite "Get your own image badge on microbadger.com")

docker-hackmd
===


[migration-to-0.5.0](https://github.com/hackmdio/migration-to-0.5.0)
---

We don't use LZString to compress socket.io data and DB data after version 0.5.0.  
Please run the migration tool if you're upgrading from the old version.

1. Stop your hackmd containers
2. Modify `docker-compose.yml`, add expose ports `5432` to `hackmdPostgres`
3. `docker-compose up` to start your hackmd containers
4. Backup DB (see below)
5. Git clone above `migration-to-0.5.0` and `npm install` (see more on above link)
6. Modify `config.json` in `migration-to-0.5.0`, change its `username`, `password` and `host` to your docker
7. Run migration (see more on above link)
8. Stop your hackmd containers
9. Modify `docker-compose.yml`, remove expose ports `5432` in `hackmdPostgres`
10. git pull in `docker-hackmd`, update to version 0.5.0 (see below)


# Prerequisite
* git
* docker (https://www.docker.com/community-edition)
* docker-compose (https://docs.docker.com/compose/install/)

See more here: https://docs.docker.com/


# Usage

## Get started

1. Install docker and docker-compose, "Docker for Windows" or "Docker for Mac"
2. Run `git clone https://github.com/hackmdio/docker-hackmd.git`
3. Change to the directory `docker-hackmd` directory
4. Run `docker-compose up` in your terminal
5. Wait until see the log `HTTP Server listening at port 3000`, it will take few minutes based on your internet connection.
6. Open http://127.0.0.1:3000


## Update

Start your docker and enter the terminal, follow below commands:

```bash
cd docker-hackmd ## enter the directory
git pull ## pull new commits
docker-compose pull ## pull new containers
docker-compose up ## turn on
```


## Backup

Start your docker and enter the terminal, follow below commands:

```bash
 docker-compose exec hackmdPostgres pg_dump hackmd -U hackmd  > backup.sql
```


## Restore

Similar to backup steps, but last command is
```bash
cat backup.sql | docker exec -i $(docker-compose ps -q hackmdPostgres) psql -U hackmd
```


# Custom build

The default setting would use pre-build docker image, if you want to build your own containers
uncomment the `build` section in the [`docker-compose.yml`](https://github.com/hackmdio/docker-hackmd/blob/master/docker-compose.yml) and edit the [`config.json`](https://github.com/hackmdio/docker-hackmd/blob/master/config.json).

If you change the database settings and don't use the `HMD_DB_URL` make sure you edit the [`.sequelizerc`](https://github.com/hackmdio/docker-hackmd/blob/master/.sequelizerc).


# License

View [license information](https://github.com/hackmdio/hackmd) for the software contained in this image.


# Supported Docker versions

This image is officially supported on Docker version 17.03.1-CE.

Support for older versions (down to 1.12) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.


# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/hackmdio/docker-hackmd/issues).

You can also reach many of the project maintainers via the `hackmd` channel on [Gitter](https://gitter.im/hackmdio/hackmd).


## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.


**Happy HackMD :smile:**
