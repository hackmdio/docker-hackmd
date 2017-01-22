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

## Prerequisite
* git
* docker (docker toolbox recommended)
* docker-compose (included in the docker toolbox)

See more here: https://www.docker.com/docker-toolbox

## Get started

1. Start you docker via `Docker Quickstart Terminal`, you will see a machine IP (remember that).
2. Run `git clone https://github.com/hackmdio/docker-hackmd.git`.
3. Run `docker-compose up` in your docker terminal.
4. Wait until see th log `HTTP Server listening at port 3000`, it will take few minutes based on your internet.
5. Open any browser and surf `<machine IP>:3000`

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

- run `docker ps` to check all your containers
```bash
➜  ~  docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES
2c04d7b1b8d4        dockerhackmd_hackmd   "/bin/bash /hackmd/do"   3 days ago          Up 17 seconds       0.0.0.0:3000->3000/tcp   dockerhackmd_hackmd_1
4949b888c1cb        postgres              "/docker-entrypoint.s"   3 days ago          Up 18 seconds       5432/tcp                 dockerhackmd_db-postgres_1
```
- backup postgresql by `docker exec <postgresql_container_id> pg_dump hackmd -U postgres > <postgresql_backup_name>`
```bash
➜  ~  docker exec 4949b888c1cb pg_dump hackmd -U postgres > postgresql_backup.sql
```
- copy your backup out of container by `docker cp <container_id>:<backup_path> <host_path>`

## Restore

Similar to backup steps, but last command is
```bash
➜  ~  cat postgresql_backup.sql | docker exec -i <container_id> psql -U hackmd
```

### Custom build

The default setting would use pre-build docker image, follow below steps to customize your HackMD.

1. Modify `docker-compose.yml` at line 8 `image: hackmdio/hackmd:0.4.6` to `build: hackmd`.
2. Change the config files `hackmd/config.js` or `hackmd/config.json`, guide [here](https://github.com/hackmdio/hackmd/#configuration-files).
3. Run `docker-compose build --no-cache` in the docker terminal to build your own image.
4. Then `docker-compose up` to startup.

*Use `--build-arg VERSION=0.4.6` to build latest release. By default the latest dev version is build.*

**Happy HackMD :smile:**
