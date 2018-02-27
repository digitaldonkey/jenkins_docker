Run Jenkins

```
docker-compose build
docker-compose up
```


Fix Docker socket permissions.
Once you need to login and manually rune entrypoint.sh.

```
docker exec -it -u root jenkinsdocker_jk_master_1 bash

root@8f1458640804:/# entrypoint.sh
Change permissions on /var/run/docker.sock
Change permissions on /apidocs
Allow jenkins writing to /apidocs

# Check
root@8f1458640804:/# ls -al /var/run/docker.sock
srw-rw---- 1 root docker 0 Feb 26 22:06 /var/run/docker.sock
```

Running this from docker-compose crashes.
