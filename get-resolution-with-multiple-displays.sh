#!/bin/bash

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

echo "Resolution: $resolution"
echo "Pixel Resolution: $pixel_resolution"
echo "Width: $width"
echo "Height: $height"
