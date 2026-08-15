#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

# entr has no prebuilt release binaries -- source tarballs only -- so apt is
# the install path here, not a fallback.
CMD=entr
NAME="entr (rerun a command when files change)"
VERSION=$(apt_version entr)

pre_run

sudo apt-get install -y entr

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD -v 2>&1 || true)"
