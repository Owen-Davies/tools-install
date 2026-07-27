#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=vim
NAME=vim

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# vim-gtk3 exists purely for system-clipboard support, and drags in the whole X
# client stack to get it. That is dead weight on a droplet or under WSL, where
# there is no display for a clipboard to live on -- so use vim-nox there.
if [ -d /usr/share/xsessions ] || [ -d /usr/share/wayland-sessions ]; then
  VIM_PKG=vim-gtk3
else
  VIM_PKG=vim-nox
fi
echo -e "\e[34m»»» 📦 \e[32mUsing package \e[33m$VIM_PKG\e[0m"
sudo apt-get install -y "$VIM_PKG"

## set vim as default git editor
git config --global core.editor "vim"

#sudo update-alternatives --set editor /usr/bin/vim

## Install vundle
mkdir -p ~/.vim/bundle
rm -rf ~/.vim/bundle/Vundle.vim
git clone -q --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

### Install vundle plugins
vim -c 'PluginInstall' -c 'qa!'

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
