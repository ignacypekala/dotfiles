#!/bin/bash
# Based on the tmux-session-dispensary by Sylvan Franklin
# https://github.com/SylvanFranklin/.config/blob/main/scripts/tmux-session-dispensary.sh
#
# Depends on skim
# https://github.com/skim-rs/skim

# Assumes an environment variable DIRS:
# WORK_DIRS=(
#     "$HOME"
#     "$HOME/wdp"
# )
mapfile -t WORK_DIRS < ~/.cache/work_dirs

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find "${WORK_DIRS[@]}" -maxdepth 1 -type 'd'  \
        | sed "s|^$HOME/|~/|" \
        | sk --margin 10% --color="bw")

    [[ $selected ]] && selected="$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

tmux switch-client -t "$selected_name"
