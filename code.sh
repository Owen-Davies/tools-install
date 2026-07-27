#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD="code"
NAME="Visual Studio Code (desktop)"

# NOTE. Deliberately NOT the same as benc-uk's code.sh, which installs the
# headless VS Code CLI tarball. This machine runs a desktop, so install the
# full app from the Microsoft apt repo.

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/packages.microsoft.gpg
sudo install -o root -g root -m 644 /tmp/packages.microsoft.gpg /usr/share/keyrings/
rm -f /tmp/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y
sudo apt-get install libasound2 -y || sudo apt-get install libasound2t64 -y

post_run
