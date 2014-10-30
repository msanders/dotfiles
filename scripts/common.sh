#!/usr/bin/env bash
set -eu

puterr() {
    msg="$1"
    >&2 echo -e "\e[31mError\e[39m: $msg"
}

export -f puterr
