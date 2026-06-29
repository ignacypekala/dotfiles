#!/usr/bin/env bash
# Symlinks dotfiles for the appropriate environment with GNU Stow.

STOW_TARGET="$HOME"

# Anchor the script relative to the script location.
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
cd "$SCRIPT_DIR" || exit 1

error() {
    local program="$0"
    echo "$program: error: $@" >&2
    exit 1
}

warn() {
    local program="$0"
    echo "$program: warn: $@" >&2
}

stow_directory() {
    path="$1"
    if ! [[ -d "$path" ]]; then
        warn "$path doesn't exist or isn't a directory"
    fi
    directory=$(dirname "$path")
    package=$(basename "$path")
    echo "Stowing $package from $directory into $STOW_TARGET"
    stow -v --no-folding --target="$STOW_TARGET" --dir="$directory" "$package"
}

stow_directory "common"

hostname=${HOSTNAME:-$(hostname)}
if [[ "$hostname" == "Grzejnik" ]]; then
    stow_directory "hosts/grzejnik-wsl"

elif [[ "$hostname" == "Laptop" ]]; then 
    stow_directory "hosts/laptop-wsl"

elif [[ -f "~/.mim" ]]; then
    stow_directory "profiles/mim"
    stow_directory "profiles/x11"

    if [[ "$hostname" == "students" ]]; then
        stow_directory "hosts/mim-students"
    else
        stow_directory "hosts/mim-labs"
    fi
elif [[ -f "/etc/NIXOS" ]]; then
    stow_directory "profiles/nixos"
    stow_directory "profiles/sway"
else
    stow_directory "hosts/unknown"
fi


