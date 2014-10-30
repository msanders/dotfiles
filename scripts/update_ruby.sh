#!/usr/bin/env bash
set -eu
. "$(dirname "$0")/common.sh"

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then
    eval "$(rbenv init -)";
else
    puterr "rbenv not installed"
    exit 1
fi

echo "Updating Ruby"
rbenv install 2.1.3 --skip-existing
rbenv global 2.1.3
gem update --system
