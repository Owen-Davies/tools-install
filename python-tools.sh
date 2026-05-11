#!/bin/bash
set -e

NAME="Python Tools"
echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

# Intentionally installed Python packages (excludes Ubuntu system packages)
pip3 install --user \
  ansible \
  apache-libcloud \
  pass-audit \
  paramiko \
  pywinrm \
  requests-ntlm \
  fido2 \
  yubikey-manager \
  pyscard

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which ansible)\e[0m"
echo -e "\e[34m»»» 💡 \e[32mAnsible version: \e[39m$(ansible --version | head -1)\e[0m"
