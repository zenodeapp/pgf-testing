#!/bin/bash

# Owner argument is required
if [ $# -eq 0 ]; then
    echo "Usage: $0 <owner>"
    exit 1
fi
owner="$1"
current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Config variable(s)
monitor_interval=$(jq -r '.monitor_interval' ./config.json)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logs get stored in the logs folder
logs_dir="./logs"
if [ ! -d "$logs_dir" ]; then
    mkdir -p "$logs_dir"
fi
log_file="$logs_dir/monitor_${owner}.log"

# Monitor start
echo -e "[$current_datetime] Monitor for ${GREEN}$owner${NC} started."
echo "[$current_datetime] Monitor for $owner started." >> "$log_file"

# Monitor loop
while true; do
  current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
  
  # Epoch monitoring
  current_epoch=$(echo "$(namada client epoch)" | awk '/Last committed epoch:/ {print $4}')

  if [ -n "$current_epoch" ]; then
    if [ "$current_epoch" != "$previous_epoch" ]; then
      if [ -z "$previous_epoch" ]; then
        # Last committed epoch echo
        echo -e "[$current_datetime] ${BLUE}Last committed epoch: $current_epoch${NC}"
        echo "[$current_datetime] Last committed epoch: $current_epoch" >> "$log_file"
      else
        # Epoch change echo
        echo -e "[$current_datetime] ${BLUE}epoch change: $current_epoch${NC}"
        echo "[$current_datetime] epoch change: $current_epoch" >> "$log_file"
      fi

      previous_epoch="$current_epoch"
    fi
  fi

  # Balance monitoring
  current_balance=$(echo "$(namada client balance --owner $owner --token nam)" | awk '/nam:/ {print $2}')

  if [ -n "$current_balance" ]; then
    if [ "$current_balance" != "$previous_balance" ]; then
      
      # Calculate and print the change in balance
      if [ -n "$previous_balance" ]; then
        change=$(echo "$current_balance - $previous_balance" | bc)

        if (( $(echo "$change < 0" | bc -l) )); then
          color=$RED
          change_sign=""
        else
          color=$GREEN
          change_sign="+"
        fi

        # Balance change echo
        echo -e "[$current_datetime] ${color}balance change: $change_sign$change nam${NC} (epoch $current_epoch)"
        echo "[$current_datetime] balance change: $change_sign$change nam (epoch $current_epoch)" >> "$log_file"
      fi

      # Normal balance echo
      echo -e "[$current_datetime] ${YELLOW}nam: $current_balance${NC}"
      echo "[$current_datetime] nam: $current_balance" >> "$log_file"
      
      previous_balance="$current_balance"
    fi
  fi

    # Sleep for the amount of seconds indicated in the config.json file
    sleep $monitor_interval
done
