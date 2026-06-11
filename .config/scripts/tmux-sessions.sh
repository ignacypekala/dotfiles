#!/bin/bash
# Based on tmux-session-dispensary by Sylvan Franklin
# https://github.com/SylvanFranklin/.config/blob/main/scripts/tmux-session-dispensary.sh
#
# Assumes presence of files ~/.cache/project_roots and ~/.cache/extra_projects.
#
# Usage:
# Select a project and open a session
# tmux-sessions.sh
# tmux-sessions.sh select project
#
# Select a directory and open a session
# tmux-sessions.sh select directory
#
# Select and open session (including hidden directories)
# tmux.sessions.sh select-all
# tmux.sessions.sh select-all project
# tmux.sessions.sh select-all directory
#
# Open/load a session in a directory
# tmux-sessions.sh open [DIRECTORY]

if [[ $1 == "open" ]]; then
    selected=$2
else
    finder=()
    extra_results=()

    # Craft the find command array
    if [[ $2 == "project" ]]; then
        mapfile -t project_roots < ~/.cache/project_roots
        mapfile -t extra_projects < ~/.cache/extra_projects

        finder=( find "${project_roots[@]}" -mindepth 1 -maxdepth 1 -type 'd' )
        extra_results+=( "${extra_projects[@]}" )
    else
        finder=( find "$PWD" -mindepth 1 -maxdepth 1 -type 'd' )
    fi

    # Exclude hidden directories
    if [[ $1 != "select-all" ]]; then
        finder+=( -not -name '.*' )
    fi

    selected=$(
        { "${finder[@]}"; printf "%s\n" ${extra_results[@]}; } \
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
