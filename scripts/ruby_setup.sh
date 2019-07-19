#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset
. "$(dirname "$0")/common.sh"

export RBENV_ROOT=/usr/local/var/rbenv
if command -v rbenv > /dev/null; then
    eval "$(rbenv init -)";
else
    puterr "rbenv not installed"
    exit 1
fi

echo "Updating Ruby"
rbenv install 2.5.5 --skip-existing
rbenv global 2.5.5
gem update --system
gem install pry rubocop

if [ "$(uname -s)" == "Darwin" ]; then
    gem terminal-notifier
fi
