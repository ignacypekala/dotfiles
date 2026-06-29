#!/usr/bin/env bash
# Open a tmux session in a given directory or in $PWD if not specified.

error() {
    code=$1
    shift
    echo "${0##*/}: $*" >&2
    exit $code
}

dir=(${1:-$PWD})

if ! [ -d "$dir" ]; then
    error 1 "$dir: Not a directory"
fi

absolute_dir=$(realpath "$dir")
session_name=$(tmux-name-sanitize.sh "$absolute_dir")

# Ensure session exists
if ! tmux has-session -t "$session_name" 2> /dev/null; then
    tmux new-session -c "$absolute_dir" -s "$session_name" -d
fi

# Open session
if [ -v TMUX ]; then
    tmux switch-client -t "$session_name"
else
    tmux attach-session -t "$session_name"
fi
