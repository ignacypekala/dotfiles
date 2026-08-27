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

        hyprlauncher
        hypridle
        hyprpaper

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
        texlivePackages.playfair
        literata
        alegreya
        alegreya-sans
        ibm-plex
        lora
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
    # Enable proprietary NVIDIA drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
    networking.nameservers = [ "192.168.1.1" ];
    networking.networkmanager.dns = "none";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?
}
