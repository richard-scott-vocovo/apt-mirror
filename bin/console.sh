#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"
docker exec -it ${CONTAINER_NAME} /bin/bash --login
