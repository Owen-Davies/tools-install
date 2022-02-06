#!/bin/bash 
set -e

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=tmux
NAME=tmux

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE
# sudo apt-get install -y tmux # No longer use this, want the latest tmux for popups

## Install Build Packages dependencies
sudo apt-get install -y libevent-dev ncurses-dev build-essential bison pkg-config

sudo apt-get install -y pkgconf autoconf
autoreconf -i -f

## Install Run Package dependencies
sudo apt-get install -y libevent ncurses

git clone https://github.com/tmux/tmux.git ~/source/tmux/
cd ~/source/tmux/
sh autogen.sh
./configure
make && sudo make install


### install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
