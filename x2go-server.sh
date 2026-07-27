#!/bin/bash 
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME=X2Go
require_systemd
require_gui

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
NAME=X2Go

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE

sudo apt-get update
sudo apt install x2goserver x2goserver-xsession -y
sudo apt install xfce4 -y

## rename hostname in /etc/hostname

echo -e "\n\e[34m»»» 💾 \e[32mInstalled"

