#!/usr/bin/env bash
# Trim a path from stdin to a preferred maximum length. Keep the first limb and
# as many trailing limbs as will fit. By default trims to 30 characters.
#
# Usage:
# path-trim.sh max_length
#
# The minimum output length is equal to: (a + b + 5), where a is the length
# of the first limb and b is the length of the last one (unless there's only
# one limb of course).

max_length=${1:-30}
readarray -d '/' -t path_limbs 

# Remove trailing new line
path_limbs[-1]="${path_limbs[-1]%'\n'}"

length=0
limbs=0

include_limb() {
    length=$(( $length + ${#path_limbs[$1]} ))
    (( limbs++ ))
}

# These two must always be included
include_limb 0
if (( ${#path_limbs[@]} > 1 )); then
    include_limb -1
fi

# Include as many limbs as will fit
index=$(( ${#path_limbs[@]} - $limbs ))
while ((
        $index >= 0 && $limbs < ${#path_limbs[@]}
        && $length + ${#path_limbs[$index]} <= $max_length
)); do
    include_limb $index
    (( index-- )) 
done

if (( $limbs > 1 )); then
    printf "%s/" ${path_limbs[0]}
else
    printf "%s" ${path_limbs[0]}
fi
(( limbs-- ))
(( index++ ))

# Check for remaining and trimmed limbs
if (( $limbs > 0 && $limbs + 1 < ${#path_limbs[@]} )); then
    printf ".../"
fi

while (( $limbs > 1 )); do
    printf "%s/" "${path_limbs[$index]}"
    (( index++ ))
    (( limbs-- ))
done

printf "%s\n" "${path_limbs[$index]}"
