#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

YCMD_DIR="$HOME/.ycmd"
ICMD_DIR="$HOME/.icmd"

if [ ! -d "$YCMD_DIR" ]; then
    git clone https://github.com/Valloric/ycmd.git "$YCMD_DIR"
fi

pushd "$YCMD_DIR"
set -x
git pull
git submodule update --init --recursive
./build.py --clang-completer --java-completer --js-completer --rust-completer
set +x
popd
echo "Installed ycmd."

if [ "$(uname -s)" == "Darwin" ]; then
    if [ ! -d "$ICMD_DIR" ]; then
        git clone https://github.com/jerrymarino/icmd "$ICMD_DIR"
    fi

    pushd "$ICMD_DIR"
    set -x
    git pull
    git submodule update --init --recursive
    ./build.py --swift-completer
    set +x
    popd
    echo "Installed icmd."
fi
