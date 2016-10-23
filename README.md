# Fileserver

A simple fileserver built on docker.

## Images
 * **[rootlogin/samba-base](https://hub.docker.com/r/rootlogin/samba-base)**: Base image with management scripts. Does not run anything.
 * **[rootlogin/samba](https://hub.docker.com/r/rootlogin/samba-base)**: Standalone smbd daemon. Provides Samba.
 * **[rootlogin/samba-nmbd](https://hub.docker.com/r/rootlogin/samba-nmbd)**: Standalone nmbd daemon. Only needed if you want NetBIOS Name resolution.
 
## Volumes

 * **/etc/samba**: Samba configuration directory
 * **/var/lib/samba**: Various Samba files (Stores authentication stuff).
 * **/var/lib/extrausers**: passwd, group and shadow files for the newly created users.
 
