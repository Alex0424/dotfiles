#!/bin/bash

sys=$(systemctl --failed --no-legend | wc -l)
usr=$(systemctl --user --failed --no-legend | wc -l)

echo "$sys + $usr"
