#!/bin/bash

# Config variable(s)
service=$(jq -r '.service' ./config.json)

# Helper call(s)
epoch=$(source ./helpers/get-epoch.sh "$1")

# Get relevant epoch log
log_epoch=$(source ./log-epoch.sh "$epoch")

# Log extraction from "Began a new epoch $epoch" to first occurence of "total supply"
total_supply=$(echo "$log_epoch" | awk -F 'total supply ' '{print $2}' | awk '{gsub(/\).$/, "", $1); print $1}' | tail -n -1) 
echo "$total_supply (epoch $epoch)"