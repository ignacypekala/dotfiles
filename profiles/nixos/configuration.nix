{ config, pkgs, ... }:

{
    imports =
        [
            ./hardware-configuration.nix
        ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

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
        gcc
        gnumake
        bash
        git
        tmux
        stow
        python3
        bear

        wl-clipboard
        brightnessctl
        playerctl
        polkit_gnome
        papirus-icon-theme

        librewolf
        fastfetch
        discord
        gimp
        obs-studio
        tidal-hifi
        nautilus

        wezterm
        ghostty
        alacritty
        quickshell

        neovim
        tree-sitter
        lua-language-server
        libclang
        jdt-language-server
        pyright

        fortune
        fzf
        ripgrep
        jq

        tree
        file
        zip
        unzip
        htop

        libnotify
    ];

    fonts.packages = with pkgs; [
        noto-fonts
        fira-sans
        jetbrains-mono
        nerd-fonts.symbols-only
        ibm-plex
    ];

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    systemd.packages = with pkgs; [
        hypridle
        hyprpaper
    ];

    systemd.user.services = {
        hyprpaper.wantedBy = [ "graphical-session.target" ];
        hypridle.wantedBy = [ "graphical-session.target" ];
    };

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.steam = {
        enable = true;
    };

    systemd = {
        user.services.polkit-gnome-authentication-agent-1 = {
            description = "polkit-gnome-authentication-agent-1";
            wantedBy = [ "graphical-session.target" ];
            wants = [ "graphical-session.target" ];
            after = [ "graphical-session.target" ];
            serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
                Restart = "on-failure";
                RestartSec = 1;
                TimeoutStopSec = 10;
            };
        };
    };

    services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = "hyprland";
        configHome = "/home/ignacy";
    };

    programs.dms-shell = {
        enable = true;
        systemd = {
            enable = true;
            restartIfChanged = true;
        };
    };

    # Enable proprietary NVIDIA drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
    };

    networking.nameservers = [ "192.168.1.1" ];
    networking.networkmanager.dns = "none";

    system.stateVersion = "26.05";
}
