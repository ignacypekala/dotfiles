#
# ~/.bashrc
#
GREEN="\[\e[32m\]"
GRAY="\[\e[90m\]"
BOLD="\[\e[1m\]"
RESET="\[\e[0m\]"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export MANPAGER="nvim +Man!"

export PROMPT_DIRTRIM=3
export PS1="${GREEN}\w${RESET} ${BOLD}${GRAY}>_${RESET} "


# Dont save duplicates in history
export HISTCONTROL=ignoreboth:erasedups

add_paths() {
	for d in "$@"; do
		[[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$PATH:$d"
	done
}

add_paths ~/.cargo/bin
. "$HOME/.cargo/env"
