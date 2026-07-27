#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

VERSION=${1:-"8.0"}
CMD=dotnet
NAME="Dotnet SDK"

pre_run

#
# 2024 - Removed the Microsoft repo, as the SDK is available in the default Ubuntu sources
#

sudo apt-get update -qq
sudo apt-get install -y -qq dotnet-sdk-"$VERSION"
sudo apt-get install -y -qq aspnetcore-runtime-"$VERSION"
sudo apt-get install -y -qq dotnet-runtime-"$VERSION"

post_run --version