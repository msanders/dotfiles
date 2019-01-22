#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

echo "Disabling netbiosd"
set -x
sudo launchctl disable system/netbiosd
