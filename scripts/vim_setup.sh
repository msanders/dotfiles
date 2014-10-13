#!/usr/bin/env bash
set -eu

puterr() {
	msg="$1"
	>&2 echo -e "\e[31mError\e[39m: $msg"
}

VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR" ]; then
    git clone git@github.com:msanders/vim-files.git "$VIM_DIR"
    git clone https://github.com/gmarik/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
else
	pushd "$VIM_DIR" >/dev/null
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
		puterr "Not a git repository: ~/.vim"
		exit 1
	fi
	popd >/dev/null
fi

vim +PluginInstall +qall
