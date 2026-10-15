# Loads nix with /nix mapped to ~/.nix
# https://gist.github.com/4piu/2d5096a090377405a9961fa96aaf9b68
#
# Auto-enter nix-user-chroot for interactive shells when not already inside mapped /nix
if [[ $- == *i* ]] && [ ! -d /nix ]; then
    CHROOT_BIN="$HOME/.local/bin/nix-user-chroot"
    NIX_BACKING_DIR="$HOME/.nix"

    if [ -x "$CHROOT_BIN" ] && [ -d "$NIX_BACKING_DIR" ]; then
        # Start zsh inside chroot and avoid re-loading global rc files repeatedly
       $CHROOT_BIN $NIX_BACKING_DIR bash -l
    fi
fi

# Load Nix profile if available
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

if [ -e /home/students/inf/i/ip479614/.nix-profile/etc/profile.d/nix.sh ]; then . /home/students/inf/i/ip479614/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
