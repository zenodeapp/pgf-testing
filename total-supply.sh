#!/bin/bash

# Config variable(s)
service=$(jq -r '.service' ./config.json)

# Helper function
echo_supply() {
  local epoch="$1"

  # Get relevant epoch log
  local log_epoch=$(source ./epoch.sh "$epoch")

  # Extract and echo the total supply from the epoch log
  total_supply=$(echo "$log_epoch" | awk -F 'total supply ' '{print $2}' | awk '{gsub(/\)[.]*$/, ""); print $1}' | tail -n 1)
  # Store total_supply in a global variable
  TOTAL_SUPPLY_RESULT="$total_supply"
  echo "Epoch $epoch: $total_supply nam"
}

echo_supply "$(source ./helpers/get-epoch.sh $1)"
total_supply_1="$total_supply"

# If a second epoch is given, then give a comparison of the total supplies.
if [ -n "$2" ]; then
  echo_supply "$2"
  total_supply_2="$total_supply"

  # Calculate and echo the difference between the two supplies
  difference=$(echo "$total_supply_2 - $total_supply_1" | bc)

  if (( $(echo "$difference < 0" | bc -l) )); then
    color='\033[0;31m'
    change_sign=""
  else
    color='\033[0;32m'
    change_sign="+"
  fi

  echo -e "Difference: ${color}$change_sign$difference nam\033[0m"
fi