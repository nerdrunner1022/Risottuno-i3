#!/usr/bin/env bash

state=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
device=$(bluetoothctl info | grep "Device" | head -n1 | awk '{print $2}')
connected=$(bluetoothctl info 2>/dev/null | grep "Connected" | awk '{print $2}')

if [[ $state == "yes" ]]; then
    if [[ $connected == "yes" ]]; then
        echo " Connected"
    else
        echo " On"
    fi
else
    echo "󰂲 Off"
fi

# Toggle functionality
if [[ $1 == "--toggle" ]]; then
    if [[ $state == "yes" ]]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
fi
