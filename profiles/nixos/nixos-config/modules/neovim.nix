{ pkgs, unstable, ... }:

{
    environment.systemPackages = with pkgs; [
        tree-sitter
        lua-language-server
        libclang
        jdt-language-server
        pyright
        fortune
    ];

    programs.neovim = {
        enable = true;
    };

}
