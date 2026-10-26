#!/usr/bin/env bash
# Lightweight helper for git subtree packages in Neovim
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
NVIM_DIR="common/.config/nvim"
PACK_DIR="$NVIM_DIR/pack/plugins"

usage() {
    cat <<EOF
Usage: $0 <command> [args]

Commands:
  add <repo_url> <start|opt> [name] [branch]
      Add a new plugin as a git subtree (using --squash)
      Example: $0 add https://github.com/folke/which-key.nvim opt which-key.nvim main

  pull <name> <start|opt> <repo_url> [branch]
      Update an existing subtree
      Example: $0 pull telescope.nvim opt https://github.com/nvim-telescope/telescope.nvim master

  build [all|fzf|luasnip|blink]
      Run build steps for plugins that require compilation
EOF
    exit 1
}

cmd="${1:-}"
shift || usage

case "$cmd" in
    add)
        url="$1"
        kind="${2:-opt}"
        name="${3:-$(basename "$url" .git)}"
        branch="${4:-master}"
        prefix="$PACK_DIR/$kind/$name"
        echo "Adding subtree $name ($branch) at $prefix..."
        git -C "$REPO_ROOT" subtree add --prefix="$prefix" "$url" "$branch" --squash
        ;;
    pull)
        name="$1"
        kind="${2:-opt}"
        url="$3"
        branch="${4:-master}"
        prefix="$PACK_DIR/$kind/$name"
        echo "Pulling updates for $name ($branch) from $url..."
        git -C "$REPO_ROOT" subtree pull --prefix="$prefix" "$url" "$branch" --squash
        ;;
    build)
        target="${1:-all}"
        cd "$REPO_ROOT/$PACK_DIR/opt"
        if [[ "$target" == "fzf" || "$target" == "all" ]] && [[ -d "telescope-fzf-native.nvim" ]]; then
            echo "Building telescope-fzf-native..."
            cmake -S telescope-fzf-native.nvim -B telescope-fzf-native.nvim/build -DCMAKE_BUILD_TYPE=Release
            cmake --build telescope-fzf-native.nvim/build --config Release
        fi
        if [[ "$target" == "luasnip" || "$target" == "all" ]] && [[ -d "luasnip" ]]; then
            echo "Building luasnip jsregexp..."
            make -C luasnip install_jsregexp 2>/dev/null || true
        fi
        if [[ "$target" == "blink" || "$target" == "all" ]] && [[ -d "blink.cmp" ]]; then
            echo "Building blink.cmp..."
            cargo build --release --manifest-path blink.cmp/Cargo.toml
            mkdir -p blink.cmp/lib
            cp -f blink.cmp/target/release/libblink_cmp_fuzzy.so blink.cmp/lib/
        fi
        ;;
    *)
        usage
        ;;
esac
