#!/bin/bash
# Pick a directory with fzf and launch a tmux session there.

selected=$(cat | path-format.sh | fzf | path-parse.sh )
[[ ! $selected ]] && exit 0
tmux-open.sh $selected
