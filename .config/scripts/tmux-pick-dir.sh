#!/bin/bash
# Pick a directory and open a tmux session there.
#
# Usage:
# tmux-pick-subdir.sh [all? true/false]

finder=( find "$HOME" -type 'd' )

if [[ $1 != "true" ]]; then
    finder+=( -not -name '.*' )
fi

"${finder[@]}" | tmux-open-dir.sh
