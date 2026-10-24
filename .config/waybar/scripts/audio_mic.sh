#!/usr/bin/env bash

while :
do
  printf '\e[2J\e[3J\e[H' # clear screen
  wpctl status
  read -p "Enter which device id to set as default (Ctrl+C to Exit): " id
  wpctl set-default $id
  echo ""
done

