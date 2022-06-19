#!/bin/bash

./env-guard.sh
result=$(echo $?)
if [[ "$result" == "1" ]]; then
  exit 1
fi

env > /etc/environment

cron -f