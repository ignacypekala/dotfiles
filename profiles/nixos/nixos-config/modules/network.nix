{ lib, ... }:

{
    networking = {
        nameservers = [];
        networkmanager = {
            enable = true;
        };
        wireless.enable = lib.mkDefault false;
    };

    services.resolved.enable = true;

    services.openssh.enable = true;
}
