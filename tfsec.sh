#!/bin/bash 
set -e

INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=tflint
NAME="tfsec"

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

curl -L "$(curl -s https://api.github.com/repos/tfsec/tfsec/releases/latest | grep -o -E "https://.+tfsec-linux-amd64")" -o /tmp/tfsec
chmod +x /tmp/tfsec
mkdir -p $INSTALL_DIR
mv /tmp/tfsec $INSTALL_DIR
rm -f /tmp/tfsec

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
