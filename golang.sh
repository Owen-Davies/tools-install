#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

get_latest_release() {
  curl --silent "https://go.dev/dl/" | grep -Po -m 1 '(\d+\.\d+\.\d+)\.linux-amd64.tar.gz"' | sed 's/.linux-amd64.tar.gz"//'
}

VERSION=${1:-"$(get_latest_release)"}
CMD=go
NAME="Go Language"

pre_run

cd /tmp
curl -fsSL "https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz" -o golang.tar.gz
sudo tar -xvf golang.tar.gz > /dev/null
sudo rm -rf /usr/local/go
rm -rf /tmp/golang.tar.gz
sudo mv go /usr/local

# NOTE. This used to append `export PATH=$PATH:/usr/local/go/bin` to ~/.bashrc
# on EVERY run. ~/.bashrc is a symlink into the dotfiles repo, so that quietly
# wrote duplicate lines into a tracked file. dotfiles/env.sh already puts
# /usr/local/go/bin on PATH, so nothing is needed here.

post_run version