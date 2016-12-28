PATH=$HOME/bin:/usr/local/bin:/Developer/usr/bin:$PATH
PS1="%2c$PR_NO_COLOR%(!.#.$) " # Nice, unobtrusive prompt.
fpath=(~/.zsh-functions $fpath) # Load my completion functions.

export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
export EDITOR=vim
export PYTHONSTARTUP=$HOME/.pyrc

# -- Intelligent completion --
autoload -Uz compinit; compinit
zstyle ':completion:*' file-patterns '%p:globbed-files:'
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/michael/.zshrc'

setopt AUTOCD # Automatically cd if command is directory name.
setopt NOMATCH # If glob shows no matches, tell me.
setopt INTERACTIVECOMMENTS # Allow comments like this in shell.
setopt MENU_COMPLETE # Display menu for ambiguous completions.
setopt BEEP # Beep.

unsetopt LIST_BEEP # Don't beep when listing a menu.
unsetopt CASE_GLOB # Ignore case in completions.
unsetopt EXTENDED_GLOB # Do not treat #, ^ and ~ as parts of patterns.

# Fix escape sequence for screen so that it adds the name of the current
# process to the title.
if [[ ${TERM} == screen ]]; then
	precmd() { print -Pn "\033k\033\134\033k\033\134" }
fi

# -- Colors! --
export CLICOLOR=1
export LANG=C # Make grep faster
export GREP_OPTIONS='--color=auto'
export LSCOLORS=cxfxexexexegedabagcxcx

# -- History --
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000 # Lines to save in memory
export SAVEHIST=10000 # Lines to save on disk

# Append to history on-the-fly (not just on exit).
setopt APPENDHISTORY INC_APPEND_HISTORY

# Ignore duplicates in history, damnit!
setopt HIST_FIND_NO_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_ALL_DUPS 

# Don't log commands beginning with a space.
setopt HIST_IGNORE_SPACE

# -- Keybindings --

# Enable vi mode.
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# Add some convenient emacs-like shortcuts too.
bindkey "" beginning-of-line
bindkey "" end-of-line
bindkey "" backward-char
bindkey "" forward-char
bindkey "" backward-word
bindkey "" forward-word
bindkey "" kill-line
bindkey "" history-incremental-search-backward

bindkey '^[[Z' reverse-menu-complete # Shift-tab to go back an item in menu.
bindkey " " magic-space # Expand variables such as !$ when space is pressed.

# alias -s -- jar='java -jar' # Automatically open .jar files with Java.

# Search history using  & .
bindkey "" history-beginning-search-backward
bindkey "" history-beginning-search-forward

# Press v in vi mode to edit line in $EDITOR.
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Load my aliases.
if [[ -f $HOME/.aliases ]]; then
	source $HOME/.aliases
fi

function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# added by travis gem
[ -f /Users/msanders/.travis/travis.sh ] && source /Users/msanders/.travis/travis.sh

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by travis gem
[ -f /Users/mks/.travis/travis.sh ] && source /Users/mks/.travis/travis.sh

# added by travis gem
[ -f /Users/yam/.travis/travis.sh ] && source /Users/yam/.travis/travis.sh
