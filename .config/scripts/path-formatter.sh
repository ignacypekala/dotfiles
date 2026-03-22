#!/bin/bash
windows_home=${WINDOWS_HOME:-novardefined}

if [[ $1 == "format" ]]; then
    cat |
    sed \
        -e "s|^$HOME|~|" \
        -e "s|^$windows_home| |"
elif [[ $1 == "parse" ]]; then
    cat |
    sed \
        -e "s|^ |$windows_home|" \
        -e "s|^~/|$HOME/|"
fi
