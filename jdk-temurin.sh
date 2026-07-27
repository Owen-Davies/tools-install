#!/bin/bash 
set -e 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

# Eclipse Temurin is the open source Java SE build based upon OpenJDK and made available by Adoptium
# See https://adoptium.net/en-GB/temurin/releases/

CMD=java
NAME="Java JDK (Temurin)"
VERSION=${1:-"11"}

pre_run

wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add - >/dev/null
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list >/dev/null
sudo apt-get -qq update
sudo apt-get install -y -q temurin-"${VERSION}"-jdk

post_run -version

echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$(javac --version)"
