#!/usr/bin/env zsh

# Icon for power menu (you can change it)
icon="⏻"

# Left-click triggers rofi-power-menu
if [[ "$1" == "click" ]]; then
  rofi -show power-menu -modi "power-menu:rofi-power-menu"
else
  echo "$icon"
fi
