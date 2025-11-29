#!/usr/bin/env bash

# Get current profile
profile=$(powerprofilesctl get)

# Display a simple icon or text based on profile
case $profile in
performance) icon="" ;;
balanced) icon="" ;;
power-saver) icon="󰌪" ;;
*) icon="?" ;;
esac

echo "$icon"

# Optional: toggle profile on click
if [[ $1 == "--toggle" ]]; then
  case $profile in
  performance) powerprofilesctl set balanced ;;
  balanced) powerprofilesctl set power-saver ;;
  power-saver) powerprofilesctl set performance ;;
  esac
fi
