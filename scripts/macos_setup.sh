#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

echo "Disabling netbiosd."
set -x
sudo launchctl disable system/netbiosd
set +x

if [ ! -d "$HOME/iCloud" ]; then
    echo "Symlinking iCloud."
    set -x
    ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs/" "$HOME/iCloud"
    set +x
else
    echo "iCloud already linked."
fi
