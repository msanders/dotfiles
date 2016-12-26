#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

puterr() {
    msg="$1"
    >&2 echo -e "\e[31mError\e[39m: $msg"
}

export -f puterr
