#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="WSL2 Interop Tools"
VERSION="n/a"

if [ -z "$WSL_DISTRO_NAME" ] && [ -z "$WSL_INTEROP" ] && ! grep -qi microsoft /proc/version 2>/dev/null; then
  skip "not running under WSL"
fi

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

# socat  -- required by the SSH/GPG agent bridge in dotfiles/profiles/wsl2/rc.sh
# wslu   -- wslview, wslpath helpers for opening things on the Windows side
# xclip  -- lets tmux/vim yank into the Windows clipboard via the X server
sudo apt-get update -y -qq
sudo apt-get install -y socat wslu xclip

echo -e "\e[34m»»» 💡 \e[32msocat: \e[39m$(socat -V | head -1)\e[0m"
