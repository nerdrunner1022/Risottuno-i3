#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch monobar
LOGFILE=/tmp/polybar-monobar.log
echo "---" | tee -a $LOGFILE
polybar monobar 2>&1 | tee -a $LOGFILE &
disown

echo "Monobar launched..."
