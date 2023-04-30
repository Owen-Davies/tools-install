#!/bin/bash 
set -e

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMM=bm
NAME=bm

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE

#################################################################
# Install bm for bookmarks management
#################################################################

## Clone bm repo
git clone https://github.com/tj/bm.git ~/source/bm

## Install bm dependencies
sudo apt-get install cutycapt xsel -y

cd ~/source/bm/
sudo make -C ~/source/bm/ install

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"