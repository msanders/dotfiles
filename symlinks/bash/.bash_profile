export EDITOR="em"
export PATH="$HOME/bin:$PATH"

# Cabal
export PATH="$PATH:$HOME/.cabal/bin"

# Homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# Rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if command -v rbenv 1>/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Cask
export PATH="$HOME/.cask/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add GHC 7.8.3 to the PATH, via http://ghcformacosx.github.io/
export GHC_DOT_APP="/opt/homebrew-cask/Caskroom/ghc/7.8.3-r1/ghc-7.8.3.app"
if [ -d "$GHC_DOT_APP" ]; then
    export PATH="${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

# added by travis gem
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME.travis/travis.sh"

# Add Postgres.app to PATH
export POSTGRES_DOT_APP="/Applications/Postgres.app"
if [ -d "$POSTGRES_DOT_APP" ]; then
    export PATH=$PATH:"$POSTGRES_DOT_APP/Contents/Versions/9.3/bin"
fi

if command -v rustc; then
    export PATH="$HOME/.cargo/bin:$PATH"
    export RUST_SRC_PATH
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

export GTAGSLABEL=pygments

# Added by Nix installer
if [ -e /home/mks/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/mks/.nix-profile/etc/profile.d/nix.sh;
fi
