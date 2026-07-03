#!/usr/bin/env bash
# Bakes all the templates from the dotfiles files with options from config.sh.
#
# Finds all files in the directory 

source ./config.sh

error() {
    local program="$0"
    echo "$program: error: $@" >&2
    exit 1
}

# {{ func(opt) }} or {{ func(opt, arg) }}
pattern='\{\{\s*([a-zA-Z]+)\s*\(\s*([a-zA-Z0-9_]+)\s*(,\s*([0-9.]+))?\s*\)\s*\}\}'

# #rrggbb -> rr, gg, bb
hex_to_rgb() {
    local hex="${1#\#}"
    local rr=$((16#${hex:0:2}))
    local gg=$((16#${hex:2:2}))
    local bb=$((16#${hex:4:2}))
    echo "$rr, $gg, $bb"
}

warn() {
    local program="$0"
    echo "$program: $file_name: line $line_nr: $@" >&2
}
    
bake_template() {
    template_file="$1"
    output_file=${template_file%.template}
    > "$output_file"

    file_name=$(basename "$template_file")
    line_nr=0

    while IFS= read -r line; do
        (( line_nr++ ))

        while [[ $line =~ $pattern ]]; do
            local full_match="${BASH_REMATCH[0]}"
            local func="${BASH_REMATCH[1]}"
            local opt="${BASH_REMATCH[2]}"
            local arg="${BASH_REMATCH[4]}"

            local value="${!opt}"
            if [[ "$value" == "" ]]; then
                warn "$opt: option doesn't exist or is empty."
            fi

            local replacement=""
            local lower_func=${func,,}
            if [[ "$lower_func" == "opt" || "$lower_func" == "hex" ]]; then
                replacement="$value"
            elif [[ "$lower_func" == "hexa" ]]; then
                replacement="${value}${arg}"
            elif [[ "$lower_func" == "hexcode" ]]; then
                replacement="${value#\#}"
            elif [[ "$lower_func" == "hexacode" ]]; then
                replacement="${value#\#}${arg}"
            elif [[ "$lower_func" == "rgb" || "$lower_func" == "rgba" ]]; then
                local rgb=$(hex_to_rgb $value)
                if [[ "$lower_func" == "rgb" ]]; then
                    replacement="rgb($rgb)"
                else
                    replacement="rgba($rgb, $arg)"
                    if [[ "$arg" == "" ]]; then
                        warn "$func: opacity is missing, replacing with an empty string."
                        replacement=""
                    fi
                fi
            else
                warn "$func: function doesn't exist, replacing with an empty string."
            fi

            if [[ "$func" != "$lower_func" ]]; then
                replacement=${replacement^^}
            fi

            line="${line/$full_match/$replacement}" 
        done
        echo "$line" >> "$output_file"
    done < "$template_file"
}

shopt -s globstar dotglob
for template in **/*.template; do
    bake_template "$template"
done
shopt -u globstar dotglob
