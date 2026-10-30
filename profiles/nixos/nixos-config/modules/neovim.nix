{ pkgs, unstable, ... }:

{
    environment.systemPackages = with pkgs; [
        tree-sitter
        lua-language-server
        libclang
        jdt-language-server
        tinymist
        pyright
        fortune
    ];

    programs.neovim = {
        enable = true;
    };

}
