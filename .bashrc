#
# ~/.bashrc
#

# Background codes are:
# 40-47 and 100-107

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export MANPAGER="nvim +Man!"

# Dont save duplicates in history
export HISTCONTROL=ignoreboth:erasedups

RESET="\e[0m"
BOLD="\e[1m"
FAINT="\e[2m"
ITALIC="\e[3m"
UNDERLINE="\e[4m"

BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

BRIGHT_BLACK="\e[90m"
BRIGHT_RED="\e[91m"
BRIGHT_GREEN="\e[92m"
BRIGHT_YELLOW="\e[93m"
BRIGHT_BLUE="\e[94m"
BRIGHT_MAGENTA="\e[95m"
BRIGHT_CYAN="\e[96m"
BRIGHT_WHTIE="\e[97m"

# Add a directory to PATH only if it exists and isn't already there
add_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

if [[ $HOSTNAME == "Grzejnik" ]]; then
    export WORK_DIRS=(
            "$HOME"
            "$HOME/wdp"
        )
    export TMUX_ACCENT="green"
    PATH_COLOR=$GREEN
elif [[ $HOSTNAME == "Laptop" ]]; then
    export WORK_DIRS=(
            "$HOME"
        )
    export TMUX_ACCENT="yellow"
    PATH_COLOR=$YELLOW
elif [[ $HOSTNAME == "students" ]]; then
    export WORK_DIRS=(
            "$HOME"
        )
    export TMUX_ACCENT="blue"
    PATH_COLOR=$BLUE
else
    export WORK_DIRS=(
        "$HOME"
        )
    export TMUX_ACCENT="red"
    PATH_COLOR=$RED
fi

# Write the WORK_DIRS to a temp file
# It is accessed by tmux-sessions.sh
update_work_dirs() {
    mkdir -p ~/.cache
    printf "%s\n" "${WORK_DIRS[@]}" > ~/.cache/work_dirs
    echo "Tmux directory cache updated with ${#WORK_DIRS[@]} paths."
}

export PROMPT_DIRTRIM=3
export PS1="${PATH_COLOR}\w${RESET} ${BRIGHT_BLACK}${BOLD}>_${RESET} "

# Change the cursor to a blinking bar
# echo -e -n "\x1b[\x36 q"

