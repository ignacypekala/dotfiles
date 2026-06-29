source ~/.bashrc

if [[ -d ~/.config/bash_profile.d ]]; then
    for bash_profiled in ~/.config/bash_profile.d/*.sh; do
        source $bash_profiled || warn "failed to source $bash_profiled"
    done
fi
