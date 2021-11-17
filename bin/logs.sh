#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"
docker logs --follow ${CONTAINER_NAME}
