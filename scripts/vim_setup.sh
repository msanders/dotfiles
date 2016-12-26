#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"

VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR" ]; then
    mkdir -p "$VIM_DIR"
fi

if [ ! -d "$VIM_DIR/bundle/Vundle.vim" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
fi

vim +PluginInstall +qall

# Compile Command-T C extension
cd "$HOME/.vim/bundle/command-t/ruby/command-t"
ruby extconf.rb >/dev/null
make >/dev/null
