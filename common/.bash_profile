source ~/.bashrc

if [[ -d ~/.config/bash_profile.d ]]; then
    for bash_profiled in ~/.config/bash_profile.d/*.sh; do
        if [[ -e $bash_profiled ]]; then
            source $bash_profiled
        fi
    done
fi
