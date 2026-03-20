#
# ~/.bashrc
#
source ~/.colors.sh

# Add a directory to PATH only if it exists and isn't already there
add_path() {
    if [ -d "$1" ] && ! [[ "$PATH" =~ $1 ]]; then
        export PATH="$1:$PATH"
    fi
}


# Source global environment variables
global_env=~/.config/env/global.sh
if [[ -f $global_env ]]; then
    source $global_env
fi

# Source machine specific environment variables
hostname=$(echo $HOSTNAME)
local_env=~/.config/env/env-$hostname.sh
if [[ -f $local_env ]]; then
    source $local_env
fi


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias car='cat'
alias nv='nvim'

export MANPAGER="nvim +Man!"

# Dont save duplicates in history
export HISTCONTROL=ignoredups

export INPUTRC=$HOME/.inputrc
set -o vi

# Background codes are:
# 40-47 and 100-107

# Write the WORK_DIRS to a temp file
# It is accessed by tmux-sessions.sh
update_work_dirs() {
    mkdir -p ~/.cache
    printf "%s\n" "${WORK_DIRS[@]}" > ~/.cache/work_dirs
    echo "Tmux directory cache updated with ${#WORK_DIRS[@]} paths."
}

export PROMPT_DIRTRIM=3
export PS1="${PATH_COLOR}\w${RESET} ${BRIGHT_BLACK}${BOLD}>_${RESET} "

