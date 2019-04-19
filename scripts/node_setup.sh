#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

echo "Updating npm dependencies."
npm install -g npm
npm install -g elm elm-live elm-format gulp gulp-elm
npm install -g typescript gulp-typescript tern
npm install -g ios-deploy
