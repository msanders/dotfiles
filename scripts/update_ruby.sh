#!/usr/bin/env bash
set -eu

export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then
	eval "$(rbenv init -)";
else
	echo "rbenv not installed"
	exit 1
fi

rbenv install 2.1.3 --skip-existing
rbenv global 2.1.3
gem update --system
