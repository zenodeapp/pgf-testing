#!/bin/bash

# Config variable(s)
service=$(jq -r '.service' ./config.json)

# Helper call(s)
epoch=$(source ./helpers/get-epoch.sh "$1")

# Log extraction from "Began a new epoch $epoch" to first occurence of "Applied x transactions"
log_epoch=$(journalctl -u $service -ocat --no-pager -n 5000 | awk -v epoch="$epoch" '
  /Began a new epoch/ { if ($NF == epoch) flag=1 }
  flag && !/Applied [0-9]+ transactions/;
  /Applied [0-9]+ transactions/ {flag=0}
')

echo "$log_epoch"