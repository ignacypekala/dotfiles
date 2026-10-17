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
            wrapGuiApp = pkg: pkgs.symlinkJoin {
                name = "${pkg.name}-chroot-wrapped";
                paths = [ pkg ];
                postBuild = ''
                    if [ -d "$out/share/applications" ]; then
                        for desktop_file in "$out/share/applications"/*.desktop; do
                            
                            # Break the symlink to modify the file safely
                            rm "$desktop_file"
                            cp "${pkg}/share/applications/$(basename "$desktop_file")" "$desktop_file"
                            chmod +w "$desktop_file"

                            # Prepend the chroot wrapper and inject the Nix profile PATH
                            # sh -c is used to find $HOME
                            sed -i "s|^Exec=\(.*\)|Exec=sh -c 'exec \"\$HOME/.local/bin/nix-user-chroot\" \"\$HOME/.nix\" env PATH=\"\$HOME/.nix-profile/bin:/usr/bin\" \"\$@\"' sh \1|g" "$desktop_file"
                        done
                    fi
                '';
            };
        in {
            packages.${system}.default = pkgs.buildEnv {
                name = "user-packages";
                paths = with pkgs; [
                    stow

                    fastfetch
                    bat
                    ripgrep

                    (wrapGuiApp ghostty)

                    clang-tools
                    bear
                    tree-sitter
                    neovim
                    fortune
                    lldb
                    asm-lsp
                    jdt-language-server
                ];
            };
        };
}
