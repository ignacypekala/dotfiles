{ config, pkgs, lib, ... }:

let
    lanzaboote = builtins.getFlake "github:nix-community/lanzaboote/v1.2.0";
in
    {
    imports = [
        lanzaboote.nixosModules.lanzaboote
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.loader.efi.canTouchEfiVariables = false;

    boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
    };

    environment.systemPackages = with pkgs; [
        sbctl
        mokutil
        efibootmgr
    ];

    systemd.services.shim-chainload = {
        description = "Sync Fedora shim and signed systemd-boot to EFI/BOOT";
        serviceConfig.Type = "oneshot";
        script = ''
      systemd_boot='/boot/EFI/systemd/systemd-bootx64.efi'
      shim='/boot/EFI/BOOT/shimx64.efi'
      bootx64='/boot/EFI/BOOT/BOOTX64.EFI'
      grub='/boot/EFI/BOOT/grubx64.efi'
      if [ -f "$systemd_boot" ] && [ -f "$shim" ]; then
          cmp -s "$shim" "$bootx64" || cp -f "$shim" "$bootx64"
          cmp -s "$systemd_boot" "$grub" || cp -f "$systemd_boot" "$grub"
      fi
      '';
        wantedBy = [ "multi-user.target" ];
    };

    systemd.paths.shim-chainload = {
        description = "Watch for Lanzaboote updates to systemd-boot";
        pathConfig.PathChanged = [
            "/boot/EFI/systemd/systemd-bootx64.efi"
            "/boot/EFI/BOOT/grubx64.efi"
        ];
        wantedBy = [ "multi-user.target" ];
    };
}
