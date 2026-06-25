# Sourced by .bashrc but also .xsessionrc
export LANG=en_US.UTF-8
export EDITOR="nvim"
export MANWIDTH=80
export MANPAGER="nvim +Man!"

export FZF_DEFAULT_OPTS="--margin 5% --color bw,gutter:0,pointer:7,separator:0 \
--no-scrollbar --no-separator"
if fzf --version >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

project_roots=(
    "$HOME"
    "$HOME/laby"
    "$HOME/laby/akso"
    "$HOME/laby/po"
)
extra_projects=(
)

add_path ~/.config/scripts
add_path ~/go/bin
add_path ~/.cargo/bin
