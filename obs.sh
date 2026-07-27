#!/bin/bash 
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="OBS Studio"
require_gui

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=obs
NAME=OBS Studio

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE

sudo apt install -y ffmpeg

## v4l2loopback-dkms is requied ffor virtual camera support
sudo apt install -y v4l2loopback-dkms

sudo add-apt-repository -y ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y obs-studio

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"