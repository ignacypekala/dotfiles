# dotfiles

Configuration files for all the machines/environments I use. The appropriate
subset of files is symlinked with GNU Stow on across a variety of environments.

You probably don't want to use these yourself, but feel free to use them as a reference.

## Structure

Here's an overview of the repo structure:

```js
.
├── common                      // sourced on every machine
│   ├── .config
│   │   ├── nvim                // ✨ N E O V I M ✨
│   │   ├── tmux
│   │   └── ...
│   └── .local
│       └── bin                 // some scripts of mine
├── hosts                       // sourced based on the hostname
│   ├── farelka
│   ├── grzejnik
│   └── unknown
└── profiles                    // various profiles; sourcing logic in install.sh
    ├── hyprland
    └── nixos
        └── nixos-config
            ├── assets
            ├── machines        // host-specific
            ├── modules         // sourced by machine or profile configs
            └── profiles
```

## Highlights
### Scripts

- `install.sh` is used to symlink `common/` and the specific combination
   of `hosts/*` and `profiles/*` to the home directory.

- `bake.sh` generates all `**/*.template` files populating them with values from
  `config.sh` nad `palette.sh`

- some packages add scripts to `.config/.local/bin`
