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
elif [[ $HOSTNAME == "Laptop" ]]; then
    export WORKDIRS=(
            "$HOME"
        )
elif [[ $HOSTNAME == "students" ]]; then
    export WORKDIRS=(
            "$HOME"
        )
fi

export PROMPT_DIRTRIM=3
export PS1="${GREEN}\w${RESET} ${BRIGHT_BLACK}${BOLD}>_${RESET} "

# Change the cursor to a blinking bar
# echo -e -n "\x1b[\x36 q"

