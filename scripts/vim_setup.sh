#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"

VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR/bundle/Vundle.vim" ]; then
    mkdir -p "$VIM_DIR/bundle"
    git clone https://github.com/gmarik/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
fi

vim +PluginUpdate +qall
