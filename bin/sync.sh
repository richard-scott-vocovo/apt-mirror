#!/bin/bash
cd $(dirname ${0})/..
bin/console.sh touch /var/spool/apt-mirror/sync
