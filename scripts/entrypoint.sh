#!/bin/bash
sync_flag="/var/spool/apt-mirror/sync"
#cat /etc/apt/mirror.list | egrep "^clean\s" | awk -F '//' '{print $2}'
nginx
while true ; do
  if [[ -e ${sync_flag} ]]; then
    /usr/bin/apt-mirror
    rm -f ${sync_flag}
  else
    sleep 60s
  fi
done
