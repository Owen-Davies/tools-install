#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

VERSION=${1:-"0.0.1"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=azd
NAME="Azure Dev CLI"

pre_run

curl -SsL https://azuresdkreleasepreview.blob.core.windows.net/azd/standalone/latest/azd-linux-amd64.tar.gz | tar -xz -C "$INSTALL_DIR" azd-linux-amd64
mv "$INSTALL_DIR"/azd-linux-amd64 "$INSTALL_DIR"/azd

post_run version