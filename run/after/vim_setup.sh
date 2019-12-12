#!/bin/sh
set -o errexit -o nounset

readonly VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR/bundle/Vundle.vim" ]; then
    mkdir -p "$VIM_DIR/bundle"
    git clone https://github.com/gmarik/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
fi

nvim +PluginUpdate +qall
