#!/usr/bin/env bash
# Pick a local subdirectory and open a tmux session there.
#
# Usage:
# tmux-pick-subdir.sh [all? true/false]

finder=( find "$PWD" -type 'd' )

if [[ $1 != "true" ]]; then
    finder+=( -not -name '.*' )
fi

"${finder[@]}" | tmux-open-dir.sh
