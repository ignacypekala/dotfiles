{ config, lib, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./secure-boot.nix
        ../../common.nix
        ../../profiles/desktop.nix
    ];
    _module.args.unstable = unstable;

    networking = {
        hostName = "farelka";
        wireless.enable = true;
    };

    system.stateVersion = "26.11";
}
