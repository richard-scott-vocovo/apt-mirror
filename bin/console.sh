#!/bin/bash
cd $(dirname ${0})/..
CONTAINER_NAME="$(basename ${PWD})"
if [[ -n "${@}" ]]; then
  CMD="-c ${@}"
else
  CMD="--login"
fi
docker exec -it ${CONTAINER_NAME} bash ${CMD}
