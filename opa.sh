#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="open-policy-agent/opa"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=opa
NAME="Open Policy Agent"

pre_run

curl -sSL https://github.com/$GITHUB/releases/download/v"${VERSION}"/opa_linux_amd64 -o "$INSTALL_DIR"/$CMD

post_run version
