#!/bin/bash
sync_flag="/var/spool/apt-mirror/sync"
nginx
while true ; do
  if [[ -e ${sync_flag} ]]; then
    /usr/bin/apt-mirror
    rm -f ${sync_flag}
  else
    sleep 600s
  fi
done
