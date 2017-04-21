#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

if ! which rustup; then
    curl https://sh.rustup.rs -sSf | sh
fi

COMPLETIONS_DIR="$HOME/.config/fish/completions"

set -x
mkdir -p "$COMPLETIONS_DIR"
rustup completions fish > "$COMPLETIONS_DIR/rustup.fish"
rustup update
