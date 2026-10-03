{ config, lib, pkgs, ... }:

let
    unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
    imports = [
        ./hardware-configuration.nix
        ./secure-boot.nix
        ../../common.nix
        ../../profiles/desktop.nix
        ../../modules/steam.nix
    ];
    _module.args.unstable = unstable;

    # networking
    networking = {
        hostName = "farelka";
        wireless.enable = true;
    };

    # security
    services.fprintd = {
        enable = true;
        tod = {
            enable = true;
            driver = pkgs.libfprint-2-tod1-broadcom;
        };
    };
    security.pam.services.greetd.fprintAuth = true;
    security.pam.services.dms-greeter.fprintAuth = true;
    security.pam.services.sudo.fprintAuth = false;
    services.displayManager = {
        defaultSession = "hyprland-uwsm";
        autoLogin = {
            enable = true;
            user = "ignacy";
        };
    };

    # power management
    services.thermald.enable = true;
    services.tlp.enable = true;
    powerManagement.enable = true;
    boot.resumeDevice = "/dev/lvm/swap";

    # hardware
    hardware.ipu6 = {
        enable = true;
        platform = "ipu6ep";
    };
    hardware.bluetooth.enable = true;

    # drivers
    boot.initrd.kernelModules = [ "i915" ];
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver
            vpl-gpu-rt
        ];
    };
    environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
    };
    hardware.enableRedistributableFirmware = true;


    system.stateVersion = "26.11";
}
