#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="Azure/bicep"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=bicep
NAME="Azure Bicep"

pre_run 

curl -sSL https://github.com/$GITHUB/releases/download/v"$VERSION"/bicep-linux-x64 -o "$INSTALL_DIR"/bicep
chmod +x "$INSTALL_DIR"/bicep

post_run