#!/usr/bin/env bash
eval "$(pyenv init -)"
set -o errexit -o pipefail

export PYTHON_CONFIGURE_OPTS="--enable-framework"
pyenv install 2.7.16 --skip-existing
pyenv install 3.6.8 --skip-existing
pyenv install 3.7.3 --skip-existing

install_dependencies() {
    pip install -U pip setuptools flake8 setuptools-rust autoflake hy yapf \
                   virtualenv
}

pyenv shell 2.7.16
install_dependencies
pyenv shell 3.6.8
install_dependencies
pyenv global 3.7.3
install_dependencies
