#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="sharkdp/bat"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=bat
NAME="bat (cat with syntax highlighting)"

pre_run

curl -sSL "https://github.com/$GITHUB/releases/download/v${VERSION}/bat-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" | \
  tar -zx -C "$INSTALL_DIR" --strip-components 1 "bat-v${VERSION}-x86_64-unknown-linux-gnu/bat"

post_run
