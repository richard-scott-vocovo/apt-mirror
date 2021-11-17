#!/bin/bash
HTTP_PORT="8888"
IMAGE_NAME="apt-mirror"
docker build . -t ${IMAGE_NAME}:latest

if ! docker volume ls -q | egrep -q "^${IMAGE_NAME}$" ; then
  docker volume create ${IMAGE_NAME}
fi

docker logs --follow $(
  docker run -d -it \
  --name=${IMAGE_NAME} \
  -e TZ=Europe/London \
  -v ${IMAGE_NAME}:/var/spool/apt-mirror \
  --restart unless-stopped \
  -p ${HTTP_PORT}:80 \
  ${IMAGE_NAME}
)
