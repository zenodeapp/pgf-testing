#!/bin/bash

# Config variable(s)
service=$(jq -r '.service' ./config.json)

# If no epoch is given as a first argument, then use the current epoch.
epoch="$1"
if [ -z "$epoch" ]; then
  epoch=$(namada client epoch | awk -F 'Last committed epoch: ' '{print $2}')
fi

# Log extraction from "Began a new epoch $epoch" to first occurence of "total supply"
epoch_logs=$(journalctl -u $service -ocat --no-pager -n 2000 | awk -v epoch="$epoch" '/Began a new epoch/ { if ($NF == epoch) flag=1 } flag; /total supply/ {flag=0}')
echo "$epoch_logs"