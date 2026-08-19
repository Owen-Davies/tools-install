#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="AppImageLauncher"
CMD=AppImageLauncher
require_gui

VERSION="n/a"

pre_run

sudo add-apt-repository -y ppa:appimagelauncher-team/stable
sudo apt-get update -y -qq
sudo apt-get install -y appimagelauncher

echo -e "\n\e[34m»»» ✅ \e[32m$NAME installed\e[0m"
