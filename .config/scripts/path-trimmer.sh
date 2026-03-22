#!/bin/bash
# Reads a path from stdin, trims the path leaving the first 
# and the very last two segments (vibe coded)
read -r input_path

# Split path into an array
IFS='/' read -ra ADDR <<< "$input_path"

# Count segments (ignoring empty elements from leading slashes)
segments=()
for i in "${ADDR[@]}"; do
    [ -n "$i" ] && segments+=("$i")
done

num_segments=${#segments[@]}

if [ "$num_segments" -le 3 ]; then
    # If 3 or fewer, just print the path
    echo "$input_path"
else
    # If more than 3, format as: first/.../n-2/n-1
    first="${segments[0]}"
    penultimate="${segments[$num_segments-2]}"
    last="${segments[$num_segments-1]}"
    
    # Handle absolute vs relative start
    [[ "$input_path" == /* ]] && prefix="/" || prefix=""
    
    echo "${prefix}${first}/.../${penultimate}/${last}"
fi
