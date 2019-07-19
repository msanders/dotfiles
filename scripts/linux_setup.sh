#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
DIRNAME="$(dirname "$0")"
source "$DIRNAME/common.sh"

if command -v apt; then
    set -x
    sudo apt install curl
    sudo apt install npm
    sudo apt install rbenv
    set +x

    if ! command -v nix-env; then
        curl https://nixos.org/nix/install | sh
    fi

    set +o errexit +o pipefail +o nounset
    source "$HOME/.nix-profile/etc/profile.d/nix.sh"
    set -o errexit -o pipefail -o nounset

    set -x
    nix-channel --update nixpkgs
    nix-env -iA nixpkgs.bat
    nix-env -iA nixpkgs.exa
    nix-env -iA nixpkgs.fd
    nix-env -iA nixpkgs.fish
    nix-env -iA nixpkgs.git
    nix-env -iA nixpkgs.ripgrep
    nix-env -iA nixpkgs.stow
    nix-env -iA nixpkgs.tealdeer
    nix-env -iA nixpkgs.vimHugeX
    set +x
elif command -v apk; then
    set -x
    apk add bash
    apk add build-base
    apk add curl
    apk add emacs
    apk add fish
    apk add git
    apk add shadow
    apk add stow
    apk add sudo
    apk add vim
    set +x
else
    puterr "Unsupported distribution."
    exit 1
fi

if ! command -v pyenv; then
    curl https://pyenv.run | bash
fi

if ! command -v rbenv; then
    export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

echo "Applying symlinks."

SYMLINK_DIR="$DIRNAME/../symlinks"

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

set -x
sudo locale-gen en_US en_US.UTF-8
sudo localedef -i en_US -f UTF-8 en_US.UTF-8

mkdir -p ~/.config
mkdir -p ~/.git_template/hooks
mkdir -p ~/.zsh-functions
mkdir -p ~/bin

stow --dir="$SYMLINK_DIR" bash --target="$HOME"
stow --dir="$SYMLINK_DIR" bin --target="$HOME/bin"
stow --dir="$SYMLINK_DIR" config --target="$HOME/.config"
stow --dir="$SYMLINK_DIR" emacs --target="$HOME"
stow --dir="$SYMLINK_DIR" git --target="$HOME"
stow --dir="$SYMLINK_DIR/git/git_template" hooks --target="$HOME/.git_template/hooks"
stow --dir="$SYMLINK_DIR" sh --target="$HOME"
stow --dir="$SYMLINK_DIR" vim --target="$HOME"
stow --dir="$SYMLINK_DIR" zsh --target="$HOME"
stow --dir="$SYMLINK_DIR" zsh-functions --target="$HOME/.zsh-functions"

echo "Running scripts."

set -x
"$DIRNAME"/emacs_setup.sh
"$DIRNAME"/haskell_setup.sh
"$DIRNAME"/node_setup.sh
"$DIRNAME"/python_setup.sh
"$DIRNAME"/ruby_setup.sh
"$DIRNAME"/rust_setup.sh
"$DIRNAME"/vim_setup.sh
"$DIRNAME"/ycmd_setup.sh
set +x
