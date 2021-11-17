#!/bin/bash
cd $(dirname ${0})
cd ..
source ./.container_name
docker exec -it ${CONTAINER_NAME} /bin/bash --login
