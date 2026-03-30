#!/bin/bash
# Based on tmux-session-dispensary by Sylvan Franklin
# https://github.com/SylvanFranklin/.config/blob/main/scripts/tmux-session-dispensary.sh
#
# Assumes the following environment variables:
# PROJECT_ROOTS=(
#     "$HOME"
#     "$HOME/projects"
# )
# EXTRA_PROJECTS=(
#     "$HOME/junk/project"
# )
#
# Usage:
# Select and open session
# tmux-sessions.sh
# tmux-sessions.sh select
#
# Select and open session (including hidden directories)
# tmux.sessions.sh select-all
#
# Open/load a session in a directory
# tmux-sessions.sh open [DIRECTORY]

if [[ $1 == "open" ]]; then
    selected=$2
else
    mapfile -t project_roots < ~/.cache/project_roots
    mapfile -t extra_projects < ~/.cache/extra_projects

    # command array
    finder=( find "${project_roots[@]}" -maxdepth 1 -type 'd' )
    if [[ $1 != "select-all" ]]; then
        # disclude hidden directories
        finder+=( -not -name '.*' )
    fi

    # Fuzzy-find across the subdirectories of $project_roots and the 
    # directories from $extra_projects
    selected=$(
        { "${finder[@]}"; printf '%s\n' "${extra_projects[@]}"; } \
        | path-formatter.sh format \
        | fzf \
        | path-formatter.sh parse \
    )
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

if [[ -v TMUX ]]; then
    tmux switch-client -t "$selected_name"
else
    tmux attach-session -t "$selected_name"
fi
