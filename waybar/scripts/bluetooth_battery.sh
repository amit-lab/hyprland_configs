#!/bin/bash

# Get the MAC address of connected Bluetooth devices
device_mac=$(bluetoothctl devices Connected | awk '{print $2}')

# If no device is connected, show empty output
if [[ -z "$device_mac" ]]; then
    echo "{}"
    exit 0
fi

# Function to get battery percentage
get_battery_percentage() {
    local mac=$1
    local battery_info

    # Extract battery percentage from bluetoothctl
    battery_info=$(bluetoothctl info "$mac" | grep "Battery Percentage" | awk '{print $3}')

    # Handle missing battery info
    [[ -z "$battery_info" ]] && echo "N/A" && return

    # Remove '0x' prefix if present
    battery_info=${battery_info#0x}

    # Convert hex to decimal if needed
    if [[ "$battery_info" =~ ^[0-9A-Fa-f]+$ ]]; then
        echo $((16#$battery_info))
    else
        echo "$battery_info"
    fi
}

# Define icons for specific devices (MAC addresses)
declare -A device_icons
device_icons=(
    ["2C:BE:EB:45:7E:32"]="🎧" # Headset
    ["XX:XX:XX:XX:XX:02"]="🎤" # Microphone
    ["XX:XX:XX:XX:XX:03"]="🎵" # Speaker
    ["D2:B8:F5:32:9D:E1"]="🖱" # Mouse
    ["XX:XX:XX:XX:XX:05"]="⌨" # Keyboard
)

# Loop through connected devices
output=""
tooltip=""
for mac in $device_mac; do
    battery=$(get_battery_percentage "$mac")

    # Skip devices with no battery info
    [[ "$battery" == "N/A" ]] && continue

    # Get icon, default to 🔋 if not in the list
    icon=${device_icons[$mac]:-"🔋"}

    # Append to Waybar display and tooltip
    output+="$icon $battery%  "
    tooltip+="$icon $mac: $battery%\n"
done

# Remove trailing newline from tooltip
tooltip=$(echo -e "$tooltip" | sed '$ d')

# Output JSON for Waybar
echo "{\"text\": \"$output\", \"tooltip\": \"$tooltip\"}"
