nix_config="profiles/mim/.config/nix"
chroot_bin="$HOME/.local/bin/nix-user-chroot"
nix_backing_dir="$HOME/.nix"
# 
# Auto-enter nix-user-chroot for interactive shells when not already inside mapped /nix .
# Launches tmux from outside the chroot envirionment when connected via SSH
# to avoid issues when reconnecting.
# 
if [[ $- == *i* ]] && [ ! -d /nix ]; then
    if [ -v SSH_CONNECTION ] && ! [ -v TMUX ]; then
        exec tmux attach || exec tmux-home.sh
    elif [ -x "$chroot_bin" ] && [ -d "$nix_backing_dir" ]; then
        exec $chroot_bin $nix_backing_dir bash -l
    fi
fi

# Enable the nix profile if available.
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

alias rebuild="nix profile upgrade $nix_config --impure"
