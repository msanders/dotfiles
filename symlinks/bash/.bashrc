# If not running interactively, don't do anything
if [ -z "$PS1" ]; then
	return;
fi

# Cabal
export PATH="$HOME/.cabal/bin:$PATH"

# Homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Make bash check its window size after a process completes
shopt -s checkwinsize

PS1='\u:\W$ '

export PATH="$HOME/bin:$PATH"
export EDITOR=vim

# Colors
export CLICOLOR=1
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GREP_OPTIONS='--color=auto'
export LSCOLORS=cxfxexexexegedabagcxcx

# History
export HISTCONTROL=erasedups,ignorespace
export HISTSIZE=1000
shopt -s histappend

# added by travis gem
[ -f /Users/msanders/.travis/travis.sh ] && source /Users/msanders/.travis/travis.sh

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
