# docker-pyload
A docker container based on [linuxserver](https://github.com/linuxserver "LinuxServer.io repositories")/[baseimage](https://github.com/linuxserver/docker-baseimage "docker-baseimage repository") and running [pyLoad](https://github.com/pyload/pyload "pyLoad repository")

## Usage
```shell
$ docker create \
  --name pyLoad \
  -p 8000:8000 \
  -e PUID=<UID> -e PGID=<GID> \
  -v </path/to/your/downloads>:/pyload/downloads \
  -v </path/to/pyload/config>:/pyload/config \
  -v /etc/localtime:/etc/localtime:ro \
  cobraeti/docker-pyload
```

### Parameters
 * -p 8000:8000 - the webUI port mapping
 * -v </path/to/your/downloads>:/pyload/downloads - path to your downloads folder
 * -v </path/to/pyload/config>:/pyload/config - where pyLoad should store it's config files
 * -v /etc/localtime:/etc/localtime:ro - Share of the host localtime (optionnal)
 * -e PUID=<UID> for UserID - see below for explanation
 * -e PGID=<GID> for GroupID - see below for explanation

### User / Group Identifiers
From LinuxServer.io description:
> TL;DR - The PGID and PUID values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).
> Part of what makes our containers work so well is by allowing you to specify your own PUID and PGID. This avoids nasty permissions errors with relation to data volumes (-v flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

### Default configs
#### WebUI port
The default port for webUI is 8000 and must stay like that. If you need to use another one, only change the port mapping when creating the container (ex: `$ docker create --name pyLoad -p <NEW PORT>:8000 ...`)

#### WebUI user
 * Default login: `USER`
 * Default password: `pyload`

You can (and should ^^) change the password through the webUI (Top right corner > Administrate > User > change).

If you want to create users, you need to run the following command on the docker host:
```shellsession
$ docker exec -it pyLoad bash
```
When you get the container's promp (something like `root@263c2ec0c11a:/#`), run the following:
```shellsession
# sudo -u abc -g abc /usr/bin/python /pyload/pyLoadCore.py -u
```
And then follow the CLI prompts to manage users.

Notes:
 * New users seems to be available only after pyLoad restart (Top right corner > Administrate > Restart pyLoad)
 * Don't forget to leave the user management script with choice 4 (Quit) or users won't be added

#### Downloads folder
The default folder for downloads is `/pyload/downloads`and must stay like that. If you need to change the destination folder for downloads, only change the volume mapping when creating the container (ex: `$ docker create --name pyLoad -v <NEW FOLDER>:/pyload/downloads ...`)
