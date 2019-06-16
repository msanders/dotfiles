#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

REPO_DIR="$(mktemp -d -t san-jose-xcode-theme)"
cd "$REPO_DIR"
git clone https://github.com/ornithocoder/san-jose-xcode-theme.git
mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
cp san-jose-xcode-theme/*.xccolortheme ~/Library/Developer/Xcode/UserData/FontAndColorThemes/
rm -rf "$REPO_DIR"
echo "Installed San Jose Xcode theme."
