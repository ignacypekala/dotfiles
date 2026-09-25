{ config, pkgs, ... }:

let 
    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
{
    disabledModules = [
            "services/display-managers/dms-greeter.nix"
            "programs/wayland/dms-shell.nix"
    ];
    imports = [
            ./hardware-configuration.nix
            <nixos-unstable/nixos/modules/services/display-managers/dms-greeter.nix>
            <nixos-unstable/nixos/modules/programs/wayland/dms-shell.nix>
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    time.timeZone = "Europe/Warsaw";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };

    services.xserver.xkb = {
        layout = "pl";
        variant = "";
    };

    users.users."ignacy" = {
        isNormalUser = true;
        description = "ignacy";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        # basic utils
        gcc
        gnumake
        bash
        git
        tmux
        stow
        python3
        bear

        tree
        file
        zip
        unzip

        # desktop utils
        wl-clipboard
        brightnessctl
        playerctl
        polkit_gnome
        papirus-icon-theme
        libnotify
        htop
        hyprcursor
        hyprshutdown
        adw-gtk3
        
        # https://discourse.nixos.org/t/how-to-use-nautilus-as-the-file-picker-dialog-portal/63490/2
        (runCommandLocal "nautilus-portal" { } ''
          mkdir -p $out/share/xdg-desktop-portal/portals
          cat > $out/share/xdg-desktop-portal/portals/nautilus.portal <<EOF
          [portal]
          DBusName=org.gnome.Nautilus
          Interfaces=org.freedesktop.impl.portal.FileChooser
          EOF
        '')    

        # desktop apps
        librewolf
        fastfetch
        vesktop
        gimp
        obs-studio
        tidal-hifi
        nautilus
        qimgv
        pinta
        kdePackages.kolourpaint

        yt-dlp
        kid3
        puddletag

        # terminals
        wezterm
        ghostty
        alacritty

        # dev environment
        tree-sitter
        lua-language-server
        libclang
        jdt-language-server
        pyright

        # dev tools
        fortune
        fzf
        ripgrep
        jq
        bat

        unstable.antigravity-cli
    ];

    programs.steam = {
        enable = true;
    };

    programs.neovim = {
        enable = true;
    };

    fonts.packages = with pkgs; [
        noto-fonts
        fira-sans
        jetbrains-mono
        nerd-fonts.symbols-only
        ibm-plex
    ];

    # window manager/compositor
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    # desktop environment
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
                hl.monitor({ 
                    output = "desc:Dell Inc. DELL S2522HG FRYK1C3",
                    mode = "1920x1080@239.757",
                    position = "0x222", scale = 1, vrr = 0 
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
            common.default = "*";
            hyprland = {
                "org.freedesktop.impl.portal.FileChooser" = "nautilus";
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

    # networking
    networking.hostName = "nixos";
    networking.nameservers = [];
    networking.networkmanager = {
        enable = true;
    };
    services.resolved.enable = true;

    # for mtp devices
    services.gvfs.enable = true;

    # polkit
    security.polkit.enable = true;
    security.soteria.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # proprietary nvidia drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
    };


    system.stateVersion = "26.05";
}
