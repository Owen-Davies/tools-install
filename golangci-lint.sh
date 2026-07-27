#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="golangci/golangci-lint"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD="golangci-lint"
NAME="Golang CI Lint"

pre_run 

curl -sSL https://github.com/$GITHUB/releases/download/v"${VERSION}"/golangci-lint-"${VERSION}"-linux-amd64.tar.gz | \
     tar -zx -C "$INSTALL_DIR" --strip-components 1 golangci-lint-"${VERSION}"-linux-amd64/$CMD

post_run