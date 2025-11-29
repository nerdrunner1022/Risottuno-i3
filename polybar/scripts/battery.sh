#!/usr/bin/env zsh

UPOWER="/usr/bin/upower"
AWK="/usr/bin/awk"
BC="/usr/bin/bc"

# Get all battery device paths
battery_paths=($($UPOWER -e | grep battery))

total_energy_full=0
total_energy_now=0
state="Unknown"

for path in "${battery_paths[@]}"; do
    energy_now=$($UPOWER -i "$path" | $AWK '/energy:/ {print $2}')
    energy_full=$($UPOWER -i "$path" | $AWK '/energy-full:/ {print $2}')
    bat_state=$($UPOWER -i "$path" | $AWK '/state:/ {print $2}')

    total_energy_now=$(echo "$total_energy_now + $energy_now" | $BC)
    total_energy_full=$(echo "$total_energy_full + $energy_full" | $BC)

    if [[ "$state" == "Unknown" && -n "$bat_state" ]]; then
        state="$bat_state"
    fi
done

percent=$(echo "scale=0; ($total_energy_now * 100) / $total_energy_full" | $BC 2>/dev/null)

[[ -z "$percent" ]] && percent=0

if (( percent <= 10 )); then
    icon=""
elif (( percent <= 30 )); then
    icon=""
elif (( percent <= 60 )); then
    icon=""
elif (( percent <= 90 )); then
    icon=""
else
    icon=""
fi

case "$state" in
    charging)
        echo " $percent%"
        ;;
    discharging)
        echo "$icon $percent%"
        ;;
    fully-charged|full)
        echo " Full"
        ;;
    *)
        echo "$icon $percent%"
        ;;
esac
