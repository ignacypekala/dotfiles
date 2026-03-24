# Sourced by .bashrc but also .xsessionrc
export LANG=en_US.UTF-8
export EDITOR="nvim"
export MANPAGER="nvim +Man!"
export TMUX_ACCENT="red"

export FZF_DEFAULT_OPTS="--margin 5% --color bw,gutter:0,pointer:7,separator:0 \
--no-scrollbar --no-separator"
if fzf --version >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

path_color=$RED
    
project_roots=(
    "$HOME"
)
extra_projects=(
)

add_path ~/.config/scripts
