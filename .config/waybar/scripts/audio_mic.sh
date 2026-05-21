#/bin/bash

while :
do
  echo "#############################################################################"
  wpctl status
  read -p "Enter which device id to set as default (Ctrl+C to Exit): " id
  wpctl set-default $id
  echo ""
done

