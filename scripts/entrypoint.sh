#!/bin/bash
sync_flag="/var/spool/apt-mirror/sync"
rm -f /etc/nginx/sites-enabled/default
cat <<EOF > /etc/nginx/sites-enabled/default
server {
  listen 80 default_server;
  server_name _;

  access_log /dev/stdout;
  error_log  /dev/stdout;

  server_name_in_redirect off;

EOF
for DIR in $(cat /etc/apt/mirror.list | egrep '^clean\s' | awk -F '//' '{print $2}') ; do
  SITE="$(echo ${DIR} | awk -F '/' '{print $1}')"
  NAME="$(echo ${DIR} | awk -F '/' '{print $2}')"
  echo "  location /${NAME} {" >> /etc/nginx/sites-enabled/default
  echo "      alias /var/spool/apt-mirror/mirror/${DIR};" >> /etc/nginx/sites-enabled/default
  echo "      autoindex on;" >> /etc/nginx/sites-enabled/default
  echo "  }" >> /etc/nginx/sites-enabled/default
done
cat <<EOF >> /etc/nginx/sites-enabled/default
}
EOF
nginx
while true ; do
  if [[ -e ${sync_flag} ]]; then
    /usr/bin/apt-mirror
    rm -f ${sync_flag}
  else
    sleep 60s
  fi
done
