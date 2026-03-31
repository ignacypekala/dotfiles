project_roots+=(
    "$HOME"
    "$HOME/laby"
)
extra_projects+=(
    "$HOME/.ssh"
)
add_path ~/.local/bin

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -t 1h)" > /dev/null
fi

