#!/bin/bash
set -e

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=pass
NAME=PasswordStore

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

## Install pass
sudo apt-get install pass -y
ln -s ~/dev/personal/pass ~/.password-store

## Install pass extensions

sudo apt-get install oathtool

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
