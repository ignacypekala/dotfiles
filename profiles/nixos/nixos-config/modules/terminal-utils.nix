{ pkgs, unstable, ... }:

{
    imports = [
        ./neovim.nix
    ];

    environment.systemPackages = with pkgs; [
        gcc
        gnumake
        bash
        tree
        file
        zip
        unzip
        pv
        htop

        stow
        bat
        btop

        git
        python3
        bear
        fastfetch
        valgrind

        tmux
        fzf
        jq
        ripgrep
    ];
}
