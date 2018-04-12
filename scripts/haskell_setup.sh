#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

if ! which stack >/dev/null; then
    curl -sSL https://get.haskellstack.org/ | sh
fi

stack update
stack upgrade
stack install apply-refact hlint stylish-haskell hasktags hoogle
