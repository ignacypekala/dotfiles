{ pkgs, ... }: {
    environment.systemPackages = [
        (pkgs.stdenv.mkDerivation {
            name = "custom-hyprcursor-bibata";
            src = ./assets/Bibata-Modern-Ice; 

            installPhase = ''
                mkdir -p $out/share/icons/Bibata-Modern-Ice
                cp -R $src/* $out/share/icons/Bibata-Modern-Ice/
            '';
        })
    ];

    environment.variables = {
        HYPRCURSOR_THEME = "Bibata-Modern-Ice";
        HYPRCURSOR_SIZE = "24";
    };
}
