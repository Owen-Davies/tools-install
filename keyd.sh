#!/bin/bash 
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME=keyd
require_systemd
require_no_wsl

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=keyd
NAME=keyd

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE

git_clone_or_pull https://github.com/rvaiya/keyd ~/source/keyd
cd ~/source/keyd
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd


echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
