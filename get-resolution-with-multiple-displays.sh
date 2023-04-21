#!/bin/bash

# This script gets the resolution of the active display on macOS, and prints
# it to stdout. It also prints the pixel resolution of the display.
#
# Example:
#   $ ./get-resolution.sh
# Resolution: 2560 x 1440
# Width: 2560
# Height: 1440
# Pixel resolution: spdisplays_5120x2880Retina
# Pixel width: 5120
# Pixel height: 2880

# Install jq if it's not installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    brew install jq
fi

output=$(system_profiler SPDisplaysDataType -json)
resolution=$(echo "$output" | jq -r '.SPDisplaysDataType[0].spdisplays_ndrvs[] | select(.spdisplays_online == "spdisplays_yes") | ._spdisplays_resolution')
pixel_resolution=$(echo "$output" | jq -r '.SPDisplaysDataType[0].spdisplays_ndrvs[] | select(.spdisplays_online == "spdisplays_yes") | .spdisplays_pixelresolution')

width=$(echo "$resolution" | jq -Rr 'match("(\\d+) x (\\d+)").captures[0].string')
height=$(echo "$resolution" | jq -Rr 'match("(\\d+) x (\\d+)").captures[1].string')

pixel_width=$(echo "$pixel_resolution" | jq -Rr 'match("(\\d+)x(\\d+)").captures[0].string')
pixel_height=$(echo "$pixel_resolution" | jq -Rr 'match("(\\d+)x(\\d+)").captures[1].string')

echo "Resolution: $resolution"
echo "Width: $width"
echo "Height: $height"

echo "Pixel resolution: $pixel_resolution"
echo "Pixel width: $pixel_width"
echo "Pixel height: $pixel_height"
