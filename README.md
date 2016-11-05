# Fileserver

A simple fileserver built on docker.

## Images
 * **[rootlogin/fileserver-base](https://hub.docker.com/r/rootlogin/fileserver-base)**: Base image with management scripts. Does not run anything.
 * **[rootlogin/samba](https://hub.docker.com/r/rootlogin/samba)**: Standalone smbd daemon. Provides Samba.
 * **[rootlogin/samba-nmbd](https://hub.docker.com/r/rootlogin/samba-nmbd)**: Standalone nmbd daemon. Only needed if you want NetBIOS Name resolution.
  * **[rootlogin/netatalk](https://hub.docker.com/r/rootlogin/netatalk)**: Standalone netatalk daemon. Let's you share files with OSX.

## Volumes

 * **/etc/fileserver**: Directory containing configuration (smb.conf, afp.conf, etc.)
 * **/var/lib/samba**: Various Samba files (Stores authentication stuff).
 * **/var/lib/extrausers**: passwd, group and shadow files for the newly created users.

## Usage with docker-compose

 * Download docker-compose.yml and edit it according to your needs.
 * Run `docker-compose up -d`
 * Your samba server is ready.

## Usage standalone

Run the main container:
```
docker run -t --name samba \
  -v /data/docker/samba/config:/etc/samba \
  -v /data/docker/samba/lib:/var/lib/samba \
  -v /data/docker/samba/users:/var/lib/extrausers \
  -v /data/public:/data/public \
  -p 138:138 \
  -p 139:139 \
  -p 445:445 \
  rootlogin/samba
```

## Management script

There is a small script included to add users and such things. You can use it with "volumes-from" in docker.
```
$ docker run --rm -ti --volumes-from samba rootlogin/samba manage
rootLogin/samba-base management utility
---------------------------------------
Usage:
manage add_user [USERNAME] [PASSWORD]
  Adds a new user.

manage add_group [GROUPNAME]
  Adds a new group.

manage add_user_to_group [USERNAME] [GROUPNAME]
  Adds a user to a group.

manage delete_user [USERNAME]
  Remove a user.

manage password [USERNAME] [PASSWORD]
  Reset a user password.
```
