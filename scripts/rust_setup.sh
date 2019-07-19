#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

if ! which rustup >/dev/null; then
    curl https://sh.rustup.rs -sSf | sh
fi

PATH="$HOME/.cargo/bin:$PATH"
COMPLETIONS_DIR="$HOME/.config/fish/completions"

set -x
mkdir -p "$COMPLETIONS_DIR"
rustup update
rustup completions fish > "$COMPLETIONS_DIR/rustup.fish"
rustup component add rust-src

set +o errexit
rustup default stable
cargo install racer --force
cargo install rustfmt --force
