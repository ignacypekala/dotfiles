{ pkgs, unstable, ... }:

{
    imports = [
        ./neovim.nix
    ];

    environment.systemPackages = with pkgs; [
        gcc
        gnumake
        bash
        stow
        tree
        file
        zip
        unzip
        pv
        bat
        htop

        git
        python3
        bear
        fastfetch

        tmux
        fzf
        jq
        ripgrep
    ];
}
