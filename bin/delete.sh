#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"
docker stop ${CONTAINER_NAME}
docker container rm ${CONTAINER_NAME}
docker image rm ${CONTAINER_NAME}
docker volume rm ${CONTAINER_NAME}
