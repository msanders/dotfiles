#!/usr/bin/env bash
set -eu

VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR" ]; then
    git clone git@github.com:msanders/vim-files.git "$VIM_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
fi

vim +PluginInstall +qall
