nixos_config="$HOME/dotfiles/nixos/configuration.nix"
alias rebuild="sudo nixos-rebuild switch -I nixos-config=$nixos_config"

path_color=$GREEN
export TMUX_ACCENT="green"

start_ssh_agent
