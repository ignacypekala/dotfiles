#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Dont save duplicates in history
export HISTCONTROL=ignoreboth:erasedups

add_paths() {
	for d in "$@"; do
		[[ -d "$d" && ! "$PATH" =~ (^|:)$d(:|$) ]] && PATH="$PATH:$d"
	done
}

add_paths ~/.cargo/bin

eval "$(zoxide init --cmd cd bash)"
