#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=lightdm
NAME=lightdm
VERSION="n/a"

pre_run

# lightdm-gtk-greeter, not the default webkit greeter -- lighter, no browser
# engine dependency chain.
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» ✅ \e[32m$NAME installed and enabled\e[0m"
