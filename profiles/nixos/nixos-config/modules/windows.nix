{ pkgs, ... }:
{
    # Start netwrok with "virsh net-start default"
    # https://search.nixos.org/packages
    environment.systemPackages = with pkgs; [ 
        # Required for the default libvirt network
        dnsmasq 
        # for clipboard
        spice-vdagent
    ];

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
}
