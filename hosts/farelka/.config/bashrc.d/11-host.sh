path_color=$YELLOW
export TMUX_ACCENT="yellow"
alias rebuild="sudo nixos-rebuild -I nixos-config=$nixos_config && sudo verify-secure-boot.sh"
alias upgrade="sudo nixos-rebuild -I nixos-config=$nixos_config --upgrade && sudo verify-secure-boot.sh"
