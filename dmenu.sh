#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=dmenu
NAME=dmenu
VERSION="n/a"

pre_run

# build-essential for a C compiler -- see dwm.sh for why this isn't left to
# base-laptop.sh alone.
sudo apt-get install -y build-essential libx11-dev libxft-dev libxinerama-dev

git_clone_or_pull https://git.suckless.org/dmenu ~/source/dmenu
cd ~/source/dmenu
make clean
sudo make clean install

# dmenu -v exits non-zero after printing its version (suckless convention),
# which would trip `set -e` inside post_run's generic `$CMD $VERFLAG` call.
echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» ✅ \e[32m$NAME built and installed\e[0m"
