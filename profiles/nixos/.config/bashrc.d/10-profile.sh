nixos_config="$HOME/nixos-config/machines/$HOSTNAME/$HOSTNAME.nix"
alias rebuild="sudo nixos-rebuild -I nixos-config=$nixos_config "
alias upgrade="sudo nixos-rebuild -I nixos-config=$nixos_config --upgrade "

start_ssh_agent
