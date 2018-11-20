#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

export PYTHON_CONFIGURE_OPTS="--enable-framework"
pyenv install 2.7.14 --skip-existing
pyenv install 3.6.7 --skip-existing
pyenv install 3.7.1 --skip-existing

install_dependencies() {
    pip install -U pip setuptools flake8 setuptools-rust autoflake hy yapf \
                   virtualenv
}

pyenv global 2.7.14
install_dependencies
pyenv global 3.6.7
install_dependencies
pyenv global 3.7.1
install_dependencies
