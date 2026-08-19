#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="obsidianmd/obsidian-releases"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
CMD=obsidian
NAME="Obsidian"

pre_run

URL="https://github.com/$GITHUB/releases/download/v${VERSION}/obsidian_${VERSION}_amd64.deb"
curl -fsSL -o /tmp/obsidian.deb "$URL"

sudo apt-get update -y -qq
sudo apt-get install -y /tmp/obsidian.deb

rm -f /tmp/obsidian.deb

post_run
