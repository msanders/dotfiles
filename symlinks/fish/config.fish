set --export DEVELOPER_DIR "/Applications/Xcode.app/Contents/Developer"
set --export EDITOR vim
set --export GITHUB_USERNAME msanders
set --export GREP_OPTIONS "--color=auto"
set --export LANG C
set --export LC_ALL en_US.UTF-8
set --export LSCOLORS cxfxexexexegedabagcxcx
set --export PATH "$HOME/bin" "/usr/local/bin" "/usr/local/sbin" $PATH
set --export PATH "/usr/local/opt/python/libexec/bin" $PATH
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

set --local CARGO_PATH "$HOME/.cargo/bin" 
if test -d $CARGO_PATH
    set --export PATH $CARGO_PATH $PATH
end

if which rustc > /dev/null
    set --export DYLD_LIBRARY_PATH (rustc --print sysroot)/lib $DYLD_LIBRARY_PATH
end

# Add GHC.app to the PATH, via http://ghcformacosx.github.io/
set --export GHC_DOT_APP "/opt/homebrew-cask/Caskroom/ghc/7.10.2-r0/ghc-7.10.2.app"
if test -d "$GHC_DOT_APP"
    set --export PATH $PATH "$HOME/.cabal/bin" "$GHC_DOT_APP/Contents/bin"
    set --export PATH "$HOME/.local/bin" $PATH
end

# Add Postgres.app to PATH
set --export POSTGRES_DOT_APP "/Applications/Postgres.app"
if test -d "$POSTGRES_DOT_APP"
    set --export PATH "/Applications/Postgres.app/Contents/Versions/latest/bin" $PATH
end

set -g fish_user_paths "/usr/local/opt/node@6/bin" $fish_user_paths
