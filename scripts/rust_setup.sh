#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

if ! which rustup >/dev/null; then
    curl https://sh.rustup.rs -sSf | sh
fi

PATH="$HOME/.cargo/bin:$PATH"
COMPLETIONS_DIR="$HOME/.config/fish/completions"

set -x
mkdir -p "$COMPLETIONS_DIR"
rustup default stable
rustup update
rustup completions fish > "$COMPLETIONS_DIR/rustup.fish"
rustup component add rust-src
rustup component add rustfmt

set +o errexit
cargo +nightly install racer --force
