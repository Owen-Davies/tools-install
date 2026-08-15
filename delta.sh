#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="dandavison/delta"
# delta's release tags carry no "v" prefix, unlike get_latest_release's default.
VERSION=${1:-"$(get_latest_release $GITHUB "")"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=delta
NAME="delta (syntax-highlighting git pager)"

pre_run

curl -sSL "https://github.com/$GITHUB/releases/download/${VERSION}/delta-${VERSION}-x86_64-unknown-linux-gnu.tar.gz" | \
  tar -zx -C "$INSTALL_DIR" --strip-components 1 "delta-${VERSION}-x86_64-unknown-linux-gnu/delta"

post_run
