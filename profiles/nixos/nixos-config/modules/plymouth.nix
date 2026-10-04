{ pkgs, ... }:

{
    boot = {
        plymouth = {
            enable = true;
            theme = "nixos-mac-style";
            themePackages = [
                (pkgs.runCommand "nixos-mac-style" {} ''
                    mkdir -p $out/share/plymouth/themes/nixos-mac-style
                    cp -r ${../assets/nixos-mac-style}/* $out/share/plymouth/themes/nixos-mac-style/
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
