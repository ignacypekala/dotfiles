{ pkgs, unstable, ... }:

{
    disabledModules = [
        "services/display-managers/dms-greeter.nix"
        "programs/wayland/dms-shell.nix"
    ];

    imports = [
        <nixos-unstable/nixos/modules/services/display-managers/dms-greeter.nix>
        <nixos-unstable/nixos/modules/programs/wayland/dms-shell.nix>
        ../modules/plymouth.nix
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

        nautilus
        gnome-disk-utility
        gparted

        # apps
        librewolf
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

        unstable.antigravity-cli
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        jetbrains-mono
        nerd-fonts.symbols-only
        ibm-plex
    ];

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.dms-shell = {
        enable = true;
        systemd = {
            enable = true;
            restartIfChanged = true;
        };
        package = unstable.dms-shell;
        quickshell.package = unstable.quickshell;
    };
    services.displayManager.dms-greeter = {
        enable = true;
        compositor = {
            name = "hyprland";
            customConfig = ''
                hl.env("DMS_RUN_GREETER", "1")
                hl.env("HYPRCURSOR_THEME", "Bibata Modern Ice")
                hl.env("HYPRCURSOR_SIZE", "24")
                hl.config({
                    animations = {
                        enabled = false,
                    },
                    misc = {
                        force_default_wallpaper = 0,
                        disable_hyprland_logo = true,
                        disable_splash_rendering = true,
                        background_color = "#000000"
                    },
                    decoration = { 
                        blur = { enabled = false },
                        shadow = { enabled = false }
                    }
                })
                hl.bind("CTRL + W", hl.dsp.send_shortcut({ mods = "CTRL", key = "BACKSPACE" }))
                hl.monitor({ 
                    output = "desc:Dell Inc. DELL S2522HG FRYK1C3",
                    mode = "1920x1080@239.757",
                    position = "auto", scale = 1, vrr = 0 
                })
                hl.monitor({ 
                    output = "desc:Hewlett Packard HP LA2306 CNC1370SDZ",
                    disabled = true
                })
            '';
        };
        configHome = "/home/ignacy";
        package = unstable.dms-greeter;
        quickshell.package = unstable.quickshell;
    };

    programs.dconf.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        config = {
            common.default = [ "gnome" ];
            hyprland = {
                default = [ "hyprland" "gnome" ];
                "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
            };
        };
    };

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
