#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="cli/cli"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=gh
NAME="GitHub CLI"

pre_run

curl -sSL https://github.com/${GITHUB}/releases/download/v"${VERSION}"/gh_"${VERSION}"_linux_amd64.tar.gz | \
  tar -zx -C "$INSTALL_DIR" --strip-components 2 gh_"${VERSION}"_linux_amd64/bin/$CMD

post_run
