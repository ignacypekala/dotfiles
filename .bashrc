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

# Source machine specific environment variables
source_env() {
    env_file=~/.config/env/$1.sh
    if [[ -e $env_file ]]; then
        source $env_file
    else
        echo $env_file doesn\'t exist
        echo $?
    fi
}

source_env global

hostname=$(echo $HOSTNAME)
envdir="~/env"
if [[ $hostname == "Grzejnik" ]]; then
    source_env grzejnik
elif [[ $hostname == "Laptop" ]]; then
    source_env laptop
elif [[ -f ~/.mim ]]; then
    source_env mim
    if [[ $hostname == "students" ]]; then
        source_env mim-students
    else
        source_env mim-labs
    fi
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias car='cat'
alias nv='nvim'
alias tm="tmux-sessions.sh open \"$PWD\""

# Dont save duplicates in history
export HISTCONTROL=ignoredups
export INPUTRC=$HOME/.inputrc

set -o vi

# Populated when setting environment variables, accessed by tmux-sessions.sh
mkdir -p ~/.cache
printf "%s\n" "${project_roots[@]}" > ~/.cache/project_roots
printf "%s\n" "${extra_projects[@]}" > ~/.cache/extra_projects

# export PROMPT_DIRTRIM=3

set_custom_prompt() {
    local path=$(pwd | path-formatter.sh format | path-trimmer.sh)
    export PS1="$path_color$path${RESET} ${BRIGHT_BLACK}${BOLD}>_${RESET} "
}
PROMPT_COMMAND=set_custom_prompt

