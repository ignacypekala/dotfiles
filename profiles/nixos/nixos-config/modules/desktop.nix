{ pkgs, unstable, ... }:
{
    imports = [
        ./cursor.nix
        ./dms.nix
    ];

    environment.systemPackages = with pkgs; [
        # environment
        wl-clipboard
        brightnessctl
        playerctl
        polkit_gnome
        papirus-icon-theme
        libnotify
        hyprcursor
        hyprshutdown
        adw-gtk3

        gnome-disk-utility
        gparted

        # apps
        librewolf

        signal-desktop
        vesktop

        gimp
        obs-studio
        tidal-hifi
        qimgv
        pinta
        kdePackages.kolourpaint

        yt-dlp
        kid3
        puddletag

        wezterm
        ghostty
        alacritty

        # lord forgive me for I am about to sin
        vscode

        unstable.antigravity-cli
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        jetbrains-mono
        nerd-fonts.symbols-only
        ibm-plex
        merriweather
        texlivePackages.garamond-math
        dejavu_fonts
        cantarell-fonts
        texlivePackages.playfair
    ];

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.dconf.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
        config = {
            common.default = [ "gnome" ];
            hyprland = {
                default = [ "hyprland" "gtk" ];
            };
        };
    };
    # add gsettings schemas to fix programs distributed as standalone binaries like ida
    environment.sessionVariables.XDG_DATA_DIRS = [
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    ];

    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [
                "ghostty.desktop"
            ];
        };
    };

    # for mtp devices
    services.gvfs.enable = true;

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
}
