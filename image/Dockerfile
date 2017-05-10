# Using `haproxy:alpine` as the base image gives us 
# a well-tailored docker image with HAProxy.
# The Dockerfile can be seen here:
# https://github.com/docker-library/haproxy/blob/master/1.7/alpine/Dockerfile
FROM haproxy:alpine

# `set -x` activates the "debug" mode, i.e, prints to stdout
# each command that is issued. From `ash`'s source code:
# https://github.com/mirror/busybox/blob/ed820ccda1a2323b5821db637ccd6dbb3dfce340/shell/ash.c#L9671-L9687
# note.: `ash` is alpine's super lightweight shell.
# 
# Here we add `rsyslog` dependency to gather the logs from
# haproxy (as haproxy never writes its logs directly to files).
#  - `vim` and `bash` are just utilities for better developing hehe.
#  - `gettext` gives us `envsubst` command which allows us to perform
# very basic templating
RUN set -x && \
    apk upgrade --update && \
    apk add rsyslog vim bash gettext && \
    rm -rf /var/cache/apk/*

# By soft-linking `/var/log/haproxy.log` to stdout all the
# logs that should go to `/var/log/haproxy.log` end up going
# to the container's `stdout`. 
RUN set -x && \
    touch /var/log/haproxy.log && \
    ln -sf /dev/stdout /var/log/haproxy.log

# Add the directory that contains our haproxy and rsyslog
# configurations to `/etc`
ADD ./etc               /etc

# Add the `entrypoint.sh` so `/usr/local/bin` (which is in $PATH)
# as the script that initializes our container. 
ADD ./entrypoint.sh     /usr/local/bin/entrypoint

ENTRYPOINT [ "entrypoint" ]

