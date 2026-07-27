#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=dockerd
NAME="Docker Engine & CLI"
VERSION=$(apt_version docker-ce)

pre_run

curl -fsSL https://get.docker.com/ | sh
sudo groupadd docker || true
sudo usermod -aG docker "$USER"

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD --version)"
echo -e "\e[34m»»» 📜 \e[32mNOTE 1: Please close this shell and open a new one to run docker without sudo"
echo -e "\e[34m»»» 📜 \e[32mNOTE 2: Docker will NOT auto start on WSL, you must run 'sudo service docker start'"
