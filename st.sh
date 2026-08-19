#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=st
NAME=st
VERSION="n/a"

pre_run

sudo apt-get install -y libx11-dev libxft-dev

git_clone_or_pull https://git.suckless.org/st ~/source/st
cd ~/source/st
make clean
sudo make clean install

# st -v exits non-zero after printing its version (suckless convention), which
# would trip `set -e` inside post_run's generic `$CMD $VERFLAG` call.
echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» ✅ \e[32m$NAME built and installed\e[0m"
