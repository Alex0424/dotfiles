#!/bin/bash

count=$(systemctl --failed --no-legend | wc -l)

if [ "$count" -eq 0 ]; then
  echo "0"
else
  echo "$count"
fi
