#!/usr/bin/env bash
set -eu
. "$(dirname "$0")/common.sh"

echo "Installing Go packages"
go get code.google.com/p/go-tour/gotour
