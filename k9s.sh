#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="derailed/k9s"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=k9s
NAME="k9s terminal UI for Kubernetes"

pre_run

curl -sSL "https://github.com/$GITHUB/releases/download/v${VERSION}/k9s_Linux_amd64.tar.gz" | \
  tar -zx -C "$INSTALL_DIR" $CMD

post_run version