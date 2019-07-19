#!/usr/bin/env bash
eval "$(pyenv init -)"
set -o errexit -o pipefail

if [ "$(uname -s)" == "Darwin" ]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
else
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
fi

pyenv install 2.7.16 --skip-existing
pyenv install 3.6.8 --skip-existing
pyenv install 3.7.3 --skip-existing

install_dependencies() {
    pip install -U pip setuptools flake8 setuptools-rust autoflake hy yapf \
                   virtualenv pylint
}

pyenv shell 2.7.16
install_dependencies
pyenv shell 3.6.8
install_dependencies
pyenv global 3.7.3
install_dependencies
