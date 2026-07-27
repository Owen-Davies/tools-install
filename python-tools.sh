#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="Python Tools"
echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

# This used `pip3 install --user`, which could not work here for two independent
# reasons:
#   1. dotfiles/env.sh exports PIP_REQUIRE_VIRTUALENV=true, so pip refuses to
#      install outside a virtualenv at all.
#   2. Ubuntu 24.04 marks the system Python as externally-managed (PEP 668), so
#      --user is rejected regardless.
# pipx is the right tool anyway: these are applications, not libraries, and each
# gets an isolated venv with only its entrypoints on PATH.

sudo apt-get update -y -qq
sudo apt-get install -y pipx
pipx ensurepath > /dev/null

# Applications -- one isolated venv each
apps=(
  ansible
  yubikey-manager
  pass-audit
)

for app in "${apps[@]}"; do
  echo -e "\e[34m»»» 📦 \e[32m$app\e[0m"
  pipx install "$app" 2>/dev/null || pipx upgrade "$app" || echo -e "\e[31m  ✖ $app failed\e[0m"
done

# Libraries that ansible modules import at runtime. They belong INSIDE ansible's
# venv rather than in one of their own -- that is what `pipx inject` is for.
echo -e "\e[34m»»» 📦 \e[32mansible runtime deps\e[0m"
pipx inject ansible \
  apache-libcloud \
  paramiko \
  pywinrm \
  requests-ntlm \
  || echo -e "\e[31m  ✖ ansible deps failed\e[0m"

# fido2 and pyscard arrive as dependencies of yubikey-manager.

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$HOME/.local/bin\e[0m"
if command -v ansible > /dev/null 2>&1; then
  echo -e "\e[34m»»» 💡 \e[32mAnsible: \e[39m$(ansible --version | head -1)\e[0m"
fi
