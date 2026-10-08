path_color=$YELLOW
export TMUX_ACCENT="yellow"
unalias rebuild
function rebuild() {
    command="$1"
    if [[ "$command" == "" ]]; then
        echo No command provided
        echo usage: rebuild boot/switch/test/...
        return 1
    fi
    sudo nixos-rebuild "$command" -I nixos-config=$nixos_config && sudo verify-secure-boot.sh
}
unalias upgrade

