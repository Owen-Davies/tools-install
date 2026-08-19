#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=zoom
NAME="Zoom"

pre_run

curl -fsSL -o /tmp/zoom_amd64.deb https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get update -y -qq
# apt (not plain dpkg -i) resolves and installs the .deb's own dependencies
sudo apt-get install -y /tmp/zoom_amd64.deb
rm -f /tmp/zoom_amd64.deb

post_run
