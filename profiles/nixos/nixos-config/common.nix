{ lib, config, pkgs, unstable, ... }:

{
    imports = [
        ./modules/terminal-utils.nix
        ./modules/network.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

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
        packages = with pkgs; [ ];
    };

    boot = {
        plymouth = {
            enable = true;
            theme = "nixos-mac-style";
            themePackages = [
                (pkgs.runCommand "nixos-mac-style" {} ''
                    mkdir -p $out/share/plymouth/themes/nixos-mac-style
                    cp -r ${./assets/nixos-mac-style}/* $out/share/plymouth/themes/nixos-mac-style/
                    substituteInPlace $out/share/plymouth/themes/nixos-mac-style/nixos-mac-style.plymouth \
                        --replace-quiet "/usr/share" "$out/share"
                '')
            ];
            extraConfig = ''
                [Daemon]
                DeviceScale=2
            '';
        };
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
            "quiet"
            "rd.udev.log_level=3"
            "rd.systemd.show_status=auto"
        ];
        loader.timeout = 0;
    };
    fonts.packages = with pkgs; [
        cantarell-fonts
    ];
    
}
