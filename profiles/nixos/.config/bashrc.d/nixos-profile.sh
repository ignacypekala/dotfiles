nixos_config="$HOME/configuration.nix"
alias rebuild="sudo nixos-rebuild switch -I nixos-config=$nixos_config"
alias upgrade="sudo nixos-rebuild switch -I nixos-config=$nixos_config --upgrade"

start_ssh_agent
