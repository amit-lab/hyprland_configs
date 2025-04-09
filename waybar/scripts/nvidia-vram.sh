#!/bin/bash

get_vram_usage() {
    # Get VRAM usage from nvidia-smi (used and total memory in MB)
    local vram_info
    vram_info=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits | head -n 1)

    # Extract values
    local vram_used=$(echo "$vram_info" | awk -F, '{print $1}' | xargs)
    local vram_total=$(echo "$vram_info" | awk -F, '{print $2}' | xargs)

    # Calculate percentage (avoid division by zero)
    if [[ "$vram_total" -gt 0 ]]; then
        local vram_percent=$((100 * vram_used / vram_total))
    else
        local vram_percent="N/A"
    fi

    # Output only the percentage for Waybar
    echo "🎮 $vram_percent%"
}

# Print VRAM usage percentage
get_vram_usage
