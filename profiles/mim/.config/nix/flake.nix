{
    description = "Nix packages for the students machine";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    outputs = { self, nixpkgs }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in {
            packages.${system}.default = pkgs.buildEnv {
                name = "user-packages";
                paths = with pkgs; [
                    stow

                    fastfetch
                    bat
                    ripgrep

                    ghostty

                    clang-tools
                    bear
                    tmux
                    tree-sitter
                    neovim
                    lldb
                    asm-lsp
                    jdt-language-server
                ];
            };
        };
}
