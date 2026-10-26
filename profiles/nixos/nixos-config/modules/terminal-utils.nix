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
        python3
        bear
        fastfetch
        valgrind
        jdk

        tmux
        fzf
        jq
        ripgrep
    ];

    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            openssl
        ];
    };
}
