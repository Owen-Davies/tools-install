#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=minecraft-launcher
NAME="Minecraft Launcher"
VERSION="n/a"

pre_run

curl -fsSL -o /tmp/minecraft-launcher.deb https://launcher.mojang.com/download/Minecraft.deb

sudo apt-get update -y -qq
sudo apt-get install -y /tmp/minecraft-launcher.deb

rm -f /tmp/minecraft-launcher.deb

post_run
