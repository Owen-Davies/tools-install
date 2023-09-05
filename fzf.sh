#!/bin/bash 
set -e

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=fzf
NAME=fzf

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# Install Search stuff - fzf ripgrep universal-ctags silversearcher-ag
# https://www.chrisatmachine.com/Neovim/08-fzf/

## INSTALL STEPS HERE
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

sudo apt-get install ripgrep universal-ctags silversearcher-ag fd-find


echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
