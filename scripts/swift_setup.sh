#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

if ! which sourcekittendaemon >/dev/null; then
    REPO_DIR="$(mktemp)/SourceKittenDaemon"
    git clone https://github.com/terhechte/SourceKittenDaemon.git "$REPO_DIR"
    pushd "$REPO_DIR"
    git checkout 0.1.7
    make install
fi
