{ config, ... }:

let
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
    imports = [
        ./hardware-configuration.nix
        ../../common.nix
        ../../profiles/desktop.nix
        ../../modules/steam.nix
        ../../modules/nvidia.nix
    ];
    _module.args.unstable = unstable;

    networking.hostName = "grzejnik";

    boot.loader = {
        systemd-boot = {
            enable = true;
            consoleMode = "max";
        };
        efi.canTouchEfiVariables = true;
    };

    system.stateVersion = "26.05";
}
