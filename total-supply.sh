#!/bin/bash

SERVICE=$(jq -r '.service' ./config.json)

journalctl -u $SERVICE --no-pager -n 1000 | grep "Total native supply" | tail -n 1 | awk -F'Total native supply: ' '{print $2}' | awk '{gsub(/\.$/, "", $1); print $1}'