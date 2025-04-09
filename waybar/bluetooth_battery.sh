#!/bin/bash

# Get the MAC address of connected Bluetooth devices
device_mac=$(bluetoothctl devices Connected | awk '{print $2}')

# If no device is connected, show nothing and exit
if [[ -z "$device_mac" ]]; then
    echo ""
    exit 0
fi

# Function to get battery percentage
get_battery_percentage() {
    local mac=$1
    local battery_info

    # Extract battery percentage from bluetoothctl info
    battery_info=$(bluetoothctl info "$mac" | grep "Battery Percentage" | awk '{print $3}')

    # If battery info is missing, return "N/A"
    [[ -z "$battery_info" ]] && echo "N/A" && return

    # Remove '0x' prefix if present (handle both decimal and hex values)
    battery_info=${battery_info#0x}

    # Convert hex to decimal if needed
    if [[ "$battery_info" =~ ^[0-9A-Fa-f]+$ ]]; then
        echo $((16#$battery_info))
    else
        echo "$battery_info" # Already decimal, return as is
    fi
}

# Define symbols for specific devices (MAC addresses)
declare -A device_icons
device_icons=(
    ["2C:BE:EB:45:7E:32"]="🎧" # Headset
    ["XX:XX:XX:XX:XX:02"]="🎤" # Microphone
    ["XX:XX:XX:XX:XX:03"]="🎵" # Speaker
    ["D2:B8:F5:32:9D:E2"]="🖱" # Mouse
    ["XX:XX:XX:XX:XX:05"]="⌨" # Keyboard
)

# Loop through connected devices
output=""
for mac in $device_mac; do
    battery=$(get_battery_percentage "$mac")

    # If battery is "N/A", skip device
    [[ "$battery" == "N/A" ]] && continue

    # Get device icon, default to 🔋 if not found
    icon=${device_icons[$mac]:-"🔋"}

    # Append to output string
    output+="$icon $battery%  "
done

# Print final output
echo "$output"
