project_roots+=(
)
extra_projects+=(
    "$HOME/.ssh"
)
add_path ~/.local/bin

add_path ~/.local/games 
export FORTUNE_PATH="$HOME/.local/share/games/fortunes"

start_ssh_agent
