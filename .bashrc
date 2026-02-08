#
# ~/.bashrc
#
GREEN="\[\e[32m\]"
BOLD="\[\e[1m\]"
RESET="\[\e[0m\]"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# PS1='[\u@\h \W]\$ '
export PROMPT_DIRTRIM=3
PS1="\n${GREEN}\w${RESET} ${BOLD}λ${RESET} "


# Dont save duplicates in history
export HISTCONTROL=ignoreboth:erasedups

add_paths() {
	for d in "$@"; do
		[[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$PATH:$d"
	done
}

add_paths ~/.cargo/bin
