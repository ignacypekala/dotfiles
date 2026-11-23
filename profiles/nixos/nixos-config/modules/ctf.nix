{ config, pkgs, unstable, ... }:

let
    pwndbg = builtins.getFlake"github:pwndbg/pwndbg/cdbcd885cd801a7e10abcfcc6f763ab287cfd000";
in
{
    environment.systemPackages = with pkgs; [
        ida-free
        gcc
        gdb
        checksec
        strace
        python3
        rlwrap
        pwndbg
        pwntools
        hyx
        bvi
    ];
}
