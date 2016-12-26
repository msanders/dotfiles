#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

DIRNAME=$(dirname "$0")
OUTDIR="$HOME/Library/KeyBindings"

# Apparently DefaultKeyBinding.dict can't be symlinked.
# See https://apple.stackexchange.com/a/53110
mkdir -p "$OUTDIR"
cp -p "$DIRNAME/DefaultKeyBinding.dict" "$OUTDIR"
echo "Installed Key Bindings."
