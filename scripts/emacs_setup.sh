#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

EMACS_DIR="$HOME/.emacs.d"
EMACS_APP_PATH="/usr/local/opt/emacs-mac/Emacs.app"

if [ ! -d "$EMACS_DIR" ]; then
    git clone https://github.com/syl20bnr/spacemacs "$EMACS_DIR"
    echo "Installed Spacemacs."
fi

if [ ! -d "$HOME/.cask" ]; then
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
fi

if [ "$(uname -s)" == "Darwin" ] && [ ! -e "/Applications/Emacs" ] && [ ! -e "/Applications/Emacs.app" ]; then
    osascript -e 'tell application "Finder"' \
              -e "make alias file to POSIX file \"$EMACS_APP_PATH\" at POSIX file \"/Applications\"" \
              -e 'end tell' >/dev/null
fi
