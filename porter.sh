#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=porter
NAME="Porter"
VERSION="0.0"
INSTALL_DIR="$HOME/.porter"

pre_run

curl -sSL https://cdn.porter.sh/latest/install-linux.sh | bash

post_run
