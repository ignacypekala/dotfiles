#
# ~/.bashrc
#

warn() {
    echo "bashrc: warn: $@"
}

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
        source "$env_file"
    else
        echo "$env_file doesn't exist"
        echo $?
    fi
}

start_ssh_agent() {
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
    if [ ! -S "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -t 1h)" > /dev/null
    fi
}

for bashrcd in ~/.config/bashrc.d/*.sh; do
    source $bashrcd || warn "failed to source $bashrcd"
done

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

set_custom_prompt() {
    # Allows scrolling between prompts
    local osc133='\[\e]133;A\e\\\]'

    local path=$(pwd | path-format.sh | path-trim-relative.sh 30 30)
    export PS1="${osc133}$path_color$path${RESET} ${BRIGHT_BLACK}${BOLD}>_${RESET} "
}
PROMPT_COMMAND=set_custom_prompt

