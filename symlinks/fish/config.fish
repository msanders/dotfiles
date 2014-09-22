# -*- coding: utf-8 -*-

set --export DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer"
set --export EDITOR gvim
set --export GREP_OPTIONS "--color=auto"
set --export HISTSIZE 10000
set --export LANG C
set --export LC_ALL en_US.UTF-8
set --export LSCOLORS cxfxexexexegedabagcxcx
set --export NODE_PATH "/usr/local/lib/node_modules"
set --export PATH "$HOME/bin" "/usr/local/bin" "/usr/local/sbin" "/usr/local/share/npm/bin" $PATH
set --export SAVEHIST 10000
set --export fish_greeting
set __fish_git_prompt_show_informative_status 'yes'

if test -f $HOME/.aliases
	. $HOME/.aliases
end

# rbenv support
set -gx RBENV_ROOT /usr/local/var/rbenv
. (rbenv init -|psub)
