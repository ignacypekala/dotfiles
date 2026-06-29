nixos_config="$HOME/configuration.nix"
alias rebuild="sudo nixos-rebuild switch -I nixos-config=$nixos_config"

start_ssh_agent
