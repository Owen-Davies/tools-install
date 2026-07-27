#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="dapr/cli"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=dapr
NAME="Dapr CLI"

pre_run

curl -SsL https://github.com/$GITHUB/releases/download/v"${VERSION}"/dapr_linux_amd64.tar.gz | \
     tar -zx -C "$INSTALL_DIR" $CMD

post_run