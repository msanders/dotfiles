#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

echo "Disabling netbiosd"
set -x
sudo launchctl disable system/netbiosd
set +x

echo "Symlinking iCloud"
set -x
ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/" "$HOME/iCloud"
