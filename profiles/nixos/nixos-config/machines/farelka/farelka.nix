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
        ../../modules/quiet-boot.nix
        ../../modules/windows.nix
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
    security.pam.services.sudo.fprintAuth = false;
    security.pam.services.greetd.fprintAuth = true;
    services.displayManager = {
        defaultSession = "hyprland-uwsm";
        autoLogin = {
            enable = true;
            user = "ignacy";
        };
    };

    # power management
    services.thermald.enable = true;
    services.upower.enable = true;
    powerManagement.enable = true;
    services.power-profiles-daemon.enable = true;
    boot.resumeDevice = "/dev/lvm/swap";
    services.logind.settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend";
        HandleLidSwitchDocked = "suspend";
    };
    systemd.sleep.settings.Sleep = {
        HibernateDelaySec="10min";
    };

    # This spell prevents a race condition between the greeter and gpu drivers.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="drm", KERNEL=="card*", TAG+="systemd"
    '';
    systemd.services.greetd = {
        wants = [ "dev-dri-card1.device" ];
        after = [ "dev-dri-card1.device" ];
    };

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
