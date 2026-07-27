#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="Oh My Zsh & Powerlevel10k"

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

if [ -d "$HOME/.oh-my-zsh" ]; then
  echo -e "\e[34m»»» ✅ \e[32moh-my-zsh already installed\e[0m"
else
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
git_clone_or_pull https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$ZSH"
