{ pkgs, unstable, ... }:

{
    imports = [
        ./neovim.nix
    ];

    environment.systemPackages = with pkgs; [
        gcc
        gnumake
        cmake
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
        bear
        fastfetch
        valgrind

        tmux
        fzf
        jq
        ripgrep

        cargo
        nodejs
        python3
        jdk
    ];

    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            openssl
        ];
    };
}
