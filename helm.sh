#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="helm/helm"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=helm
NAME="Helm"

pre_run

curl -fsSL "https://get.helm.sh/helm-v$VERSION-linux-amd64.tar.gz" | \
     tar -zx -C "$INSTALL_DIR" --strip-components 1 linux-amd64/$CMD

post_run version
