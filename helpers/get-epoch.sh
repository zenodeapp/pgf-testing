#!/bin/bash

# If no epoch is given as a first argument, then use the current epoch.
epoch="$1"
if [ -z "$epoch" ]; then
  epoch=$(namada client epoch | awk -F 'Last committed epoch: ' '{print $2}')
fi

echo "$epoch"