#!/usr/bin/env bash
# Open tmux in one of the project directories. Optionally include hidden files.
# 
# Usage:
# tmux-pick-project.sh [all? true/false]

error() {
    code=$1
    shift
    echo "${0##*/}: $*" >&2
    exit $code
}

project_roots_file=~/.cache/project_roots
if ! [[ -f "$project_roots_file" ]]; then
    error 1 "$project_roots_file: Not a file"
fi
mapfile -t project_roots < "$project_roots_file"

extra_projects_file=~/.cache/extra_projects
if ! [[ -f "$extra_projects_file" ]]; then
    error 2 "$extra_projects_file: Not a file"
fi
mapfile -t extra_projects < "$extra_projects_file"

finder=( find "${project_roots[@]}" -mindepth 1 -maxdepth 1 -type 'd' )
extra_results+=( "${extra_projects[@]}" )

if [[ $1 != "true" ]]; then
    finder+=( -not -name '.*' )
fi

{ "${finder[@]}"; printf "%s\n" ${extra_results[@]}; } | tmux-open-dir.sh

