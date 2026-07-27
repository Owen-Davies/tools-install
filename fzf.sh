#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=fzf
NAME=fzf

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# Install Search stuff - fzf ripgrep universal-ctags silversearcher-ag
# https://www.chrisatmachine.com/Neovim/08-fzf/

## INSTALL STEPS HERE
# git_clone_or_pull, not a bare clone: a bare clone into a fixed directory
# fails on the second run, which broke re-running this script.
git_clone_or_pull https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

sudo apt-get install -y ripgrep universal-ctags silversearcher-ag fd-find


echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
