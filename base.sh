#!/bin/bash
set -e
NAME="Various Linux Utilities"

# Basic base/core packages

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33mBase Core Tools & Packages\e[0m ..."

sudo add-apt-repository -y universe
sudo apt-get update -y -qq
sudo apt-get install -y \
  jq \
  curl \
  make \
  git \
  wget \
  unzip \
  fzf \
  apt-transport-https \
  lsb-release \
  gnupg \
  gnupg2 \
  shellcheck \
  ncdu \
  hey \
  figlet \
  net-tools \
  htop

# Chain on to the editor/shell/language basics
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
bash "$DIR"/vim.sh
bash "$DIR"/tmux.sh
bash "$DIR"/golang.sh
