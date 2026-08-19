#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=steam
NAME="Steam"

pre_run

sudo add-apt-repository -y multiverse
sudo dpkg --add-architecture i386
sudo apt-get update -y -qq
sudo apt-get install -y steam-installer

post_run
