#!/bin/bash 
set -e 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

# The Microsoft Build of OpenJDK
# See https://learn.microsoft.com/en-us/java/openjdk/overview

CMD=java
NAME="Java JDK (OpenJDK Microsoft)"
VERSION=${1:-"11"} # Either 11 or 17

pre_run

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/"$(lsb_release -rs)"/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
# Register the Microsoft repository GPG keys
sudo dpkg -i /tmp/packages-microsoft-prod.deb
rm -f /tmp/packages-microsoft-prod.deb

sudo apt-get update -qq
sudo apt-get install msopenjdk-"$VERSION"

post_run --version