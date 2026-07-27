#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=ngrok
NAME="ngrok"
INSTALL_DIR=${2:-"$HOME/.local/bin"}
VERSION="2"

pre_run

wget -q "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip" -O /tmp/ngrok.zip
unzip -o /tmp/ngrok.zip -d "$INSTALL_DIR" > /dev/null
rm -f /tmp/ngrok.zip

post_run