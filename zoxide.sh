#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="ajeetdsouza/zoxide"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=zoxide
NAME="zoxide (smarter cd)"

pre_run

curl -sSL "https://github.com/$GITHUB/releases/download/v${VERSION}/zoxide-${VERSION}-x86_64-unknown-linux-musl.tar.gz" | \
  tar -zx -C "$INSTALL_DIR" $CMD

echo -e "\e[34m»»» 📢 \e[33mAdd \`eval \"\$(zoxide init bash)\"\` (or zsh) to your shell rc to enable \`z\`/\`zi\`"

post_run
