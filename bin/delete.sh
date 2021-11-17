#!/bin/bash
cd $(dirname ${0})
cd ..
source ./.container_name

docker stop ${CONTAINER_NAME}
docker container rm ${CONTAINER_NAME}
docker image rm ${CONTAINER_NAME}
docker volume rm ${CONTAINER_NAME}
