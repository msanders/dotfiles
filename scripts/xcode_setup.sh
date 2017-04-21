#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

curl -fsSL https://raw.githubusercontent.com/supermarin/Alcatraz/deploy/Scripts/install.sh | sh
