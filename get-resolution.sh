#!/bin/bash

# Install jq if it's not installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    brew install jq
fi

output=$(system_profiler SPDisplaysDataType -json)

# Look for the display with "spdisplays_main" set to "spdisplays_yes" (main display)
main_display=$(echo "$output" | jq '.SPDisplaysDataType[].spdisplays_ndrvs[] | select(.spdisplays_main == "spdisplays_yes")')

resolution=$(echo "$main_display" | jq -r '._spdisplays_resolution')
pixel_resolution=$(echo "$main_display" | jq -r '._spdisplays_pixels')

# Extract width and height from the resolution
IFS=' x ' read -ra resolution_parts <<< "$resolution"
width=${resolution_parts[0]}
height=${resolution_parts[1]}

echo "Resolution: $resolution"
echo "Width: $width"
echo "Height: $height"
echo "Pixel Resolution: $pixel_resolution"
