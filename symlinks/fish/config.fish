# -*- coding: utf-8 -*-

set --export DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer"
set --export EDITOR gvim
set --export GITHUB_USERNAME msanders
set --export GOPATH "$HOME/go"
set --export GREP_OPTIONS "--color=auto"
set --export HISTSIZE 10000
set --export LANG C
set --export LC_ALL en_US.UTF-8
set --export LSCOLORS cxfxexexexegedabagcxcx
set --export NODE_PATH "/usr/local/lib/node_modules"
set --export PATH "$HOME/bin" "/usr/local/bin" "/usr/local/sbin" "/usr/local/share/npm/bin" "$GOPATH/bin" $PATH
set --export SAVEHIST 10000
set --export fish_greeting
set __fish_git_prompt_show_informative_status 'yes'

if test -f $HOME/.aliases
	. $HOME/.aliases
end

if test -f $HOME/.secrets
	. $HOME/.secrets
end

set fish_color_normal normal
set fish_color_command ffd700
set fish_color_quote normal
set fish_color_redirection normal
set fish_color_end ffffff
set fish_color_error ff5f5f --bold
set fish_color_param ffff5f
set fish_color_comment 87ffff
set fish_color_match cyan
set fish_color_search_match ffffff --background=005f00
set fish_color_operator cyan
set fish_color_escape cyan
set fish_color_cwd green

# rbenv support
set -gx RBENV_ROOT /usr/local/var/rbenv
if which rbenv > /dev/null
    . (rbenv init - fish|psub)
end

# Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
set --export GHC_DOT_APP "/opt/homebrew-cask/Caskroom/ghc/7.8.3-r1/ghc-7.8.3.app"
if test -d "$GHC_DOT_APP"
    set --export PATH "$HOME/.cabal/bin" "$GHC_DOT_APP/Contents/bin" $PATH
end

# Add Postgres.app to PATH
set --export POSTGRES_DOT_APP "/Applications/Postgres.app"
if test -d "$POSTGRES_DOT_APP"
    set --export PATH "$POSTGRES_DOT_APP/Contents/Versions/9.3/bin" $PATH
end
