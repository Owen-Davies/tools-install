#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="ahmetb/kubectx"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=kubectx
NAME="kubectx & kubens"

pre_run

curl -sSL https://github.com/${GITHUB}/releases/download/v"${VERSION}"/kubectx_v"${VERSION}"_linux_x86_64.tar.gz | \
  tar -zx -C "$INSTALL_DIR" kubectx
curl -sSL https://github.com/${GITHUB}/releases/download/v"${VERSION}"/kubens_v"${VERSION}"_linux_x86_64.tar.gz | \
  tar -zx -C "$INSTALL_DIR" kubens

post_run