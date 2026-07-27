#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="Kong/insomnia"
VERSION=${1:-"3.15.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=inso
NAME="Insomnia CLI"

pre_run

curl -sSL "https://github.com/$GITHUB/releases/download/lib%40${VERSION}/inso-linux-${VERSION}.tar.xz" | \
    tar -xJ -C "$INSTALL_DIR" $CMD

post_run