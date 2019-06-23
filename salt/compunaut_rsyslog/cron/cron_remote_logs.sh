#!/bin/bash

/usr/bin/find /srv/remote_logs/ -type f -mtime +90 -delete
/usr/bin/find /srv/remote_logs/ -type f -mtime +1 -exec gzip -9 {} \;
