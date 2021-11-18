#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"
if [[ -n "${@}" ]]; then
  CMD="${@}"
else
  CMD="bash --login"
fi
docker exec -it ${CONTAINER_NAME} "${CMD}"
