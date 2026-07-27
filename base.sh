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

# NOTE. This used to chain on to vim.sh, tmux.sh and golang.sh. It no longer
# does: install-profile.sh lists them in profiles/base.txt, and the chaining
# meant each one ran twice (golang.sh appended to ~/.bashrc on every run).
# The manifest is the single ordering authority now.
