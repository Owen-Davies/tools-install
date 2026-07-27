#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

VERSION=${1:-"24"}
CMD=node
NAME="Node.js"

pre_run

curl -sL "https://deb.nodesource.com/setup_${VERSION}.x" | sudo -E bash -
sudo apt install -y nodejs

post_run --version
echo -e "\e[34m»»» 💡 \e[32mNPM version details: \e[39m$(npm --version)"
