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
        bash
        git
        tmux
        stow
        python3

        wl-clipboard

        librewolf
        fastfetch
        discord
        gimp
        obs-studio

        wezterm
        ghostty
        alacritty

        hyprlauncher
        hypridle
        hyprpaper

        neovim
        tree-sitter
        lua-language-server
        libclang
        jdt-language-server

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
    ];

    services.gnome.gnome-keyring.enable = true;

    systemd.user.services.hyprpaper.enable = true;

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    programs.steam = {
        enable = true;
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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?

}
