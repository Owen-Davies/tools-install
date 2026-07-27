#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=az
NAME="Azure CLI"

pre_run

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az extension add --name azure-devops

post_run
