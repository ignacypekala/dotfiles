export WORK_DIRS=(
    "$HOME"
    "$HOME/laby"
)
add_path ~/.local/bin

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" > /dev/null
fi

