#!/usr/bin/env bash

# Read the 1-minute load average (first value in /proc/loadavg)
load=$(cut -d ' ' -f1 /proc/loadavg)

# Icon for load
icon=""

echo "$icon $load"
