#!/bin/bash 
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

GITHUB="hashicorp/terraform"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=terraform
NAME="Terraform"

pre_run

curl -sSL "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip" -o /tmp/tf.zip
unzip /tmp/tf.zip -d /tmp > /dev/null
mkdir -p "$INSTALL_DIR"
mv /tmp/terraform "$INSTALL_DIR"
rm -f /tmp/tf.zip

post_run
