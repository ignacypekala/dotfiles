{ pkgs, unstable, ... }: 

let
    dank-calendar = builtins.getFlake "github:AvengeMedia/dankcalendar/ecdfbac5271e68a5989d8d86689fb8c2ea8ddca1";
    dux-files = builtins.getFlake "github:duxlabs-dev/dux-files/73581769072cd40e539a16c627afe6bb18ae75ad";
in
{
    disabledModules = [
        "services/display-managers/dms-greeter.nix"
        "programs/wayland/dms-shell.nix"
    ];

    imports = [
        dank-calendar.nixosModules.default
        <nixos-unstable/nixos/modules/services/display-managers/dux-greeter.nix>
        <nixos-unstable/nixos/modules/programs/wayland/dux-shell.nix>
        dux-files.nixosModules.dux-files
    ];

    programs.dux-shell = {
        enable = true;
        systemd = {
            enable = true;
            restartIfChanged = true;
        };
        package = unstable.dux-shell;
        quickshell.package = unstable.quickshell;
    };
    services.displayManager.dux-greeter = {
        enable = true;
        compositor = {
            name = "hyprland";
            customConfig = ''
                hl.env("DMS_RUN_GREETER", "1")
                hl.config({
                    animations = {
                        enabled = false,
                    },
                    misc = {
                        force_default_wallpaper = 0,
                        disable_hyprland_logo = true,
                        disable_splash_rendering = true,
                        background_color = "#000000"
                    },
                    decoration = { 
                        blur = { enabled = false },
                        shadow = { enabled = false }
                    }
                })
                hl.bind("CTRL + W", hl.dsp.send_shortcut({ mods = "CTRL", key = "BACKSPACE" }))
                hl.monitor({ 
                    output = "desc:Dell Inc. DELL S2522HG FRYK1C3",
                    mode = "1920x1080@239.757",
                    position = "auto", scale = 1, vrr = 0 
                })
                hl.monitor({ 
                    output = "desc:Hewlett Packard HP LA2306 CNC1370SDZ",
                    disabled = true
                })
            '';
        };
        configHome = "/home/ignacy";
        configFiles = [
            "/home/ignacy/.config/dank-greeter/settings.json"
        ];
        package = unstable.dux-greeter;
        quickshell.package = unstable.quickshell;
    };
    programs.dank-calendar = {
        enable = true;
        package = dank-calendar.packages.${pkgs.stdenv.hostPlatform.system}.default;
        quickshell.package = unstable.quickshell;
    };
    programs.dux-files = {
        enable = true;
        portal = {
            enable = true;
            preferred = true;
        };
    };

    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [
                "ghostty.desktop"
            ];
        };
    };

    # for mtp devices
    services.gvfs.enable = true;

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;

    # printing
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };
    services.printing = {
        enable = true;
        drivers = with pkgs; [
            cups-filters
            cups-browsed

            pkgs.epson-escpr
            pkgs.epson-escpr2
        ];
    };
    users.users."ignacy".extraGroups = [ "lp" ];
}
