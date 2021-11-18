#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"

EXPOSED_PORT="8888"

docker stop ${CONTAINER_NAME}
docker container rm ${CONTAINER_NAME} --force
docker image rm ${CONTAINER_NAME} --force
docker build ${PWD} -t ${CONTAINER_NAME}:latest

if ! docker volume ls -q | egrep -q "^${CONTAINER_NAME}$" ; then
  docker volume create ${CONTAINER_NAME}
fi

docker run -d -it \
 --name=${CONTAINER_NAME} \
 -e TZ=Europe/London \
 -v ${CONTAINER_NAME}:/var/spool/apt-mirror \
 --restart unless-stopped \
 -p ${EXPOSED_PORT}:80 \
 ${CONTAINER_NAME}
