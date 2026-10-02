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
    ];
    _module.args.unstable = unstable;

    networking = {
        hostName = "farelka";
        wireless.enable = true;
    };
    hardware.bluetooth.enable = true;

    services.fprintd = {
        enable = true;
        tod = {
            enable = true;
            driver = pkgs.libfprint-2-tod1-broadcom;
        };
    };
    security.pam.services.greetd.fprintAuth = true;
    security.pam.services.dms-greeter.fprintAuth = true;

    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;

    # webcam
    hardware.ipu6 = {
        enable = true;
        platform = "ipu6ep";
    };

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
