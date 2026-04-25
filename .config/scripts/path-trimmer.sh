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

if [ "$num_segments" -le 4 ]; then
    # If 4 or fewer, just print the path
    echo "$input_path"
else
    # If more than 4, format as: first/.../n-3/n-2/n-1
    first="${segments[0]}"
    n_3="${segments[$num_segments-3]}"
    n_2="${segments[$num_segments-2]}"
    n_1="${segments[$num_segments-1]}"
    
    # Handle absolute vs relative start
    [[ "$input_path" == /* ]] && prefix="/" || prefix=""
    
    echo "${prefix}${first}/.../${n_3}/${n_2}/${n_1}"
fi
