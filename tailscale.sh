#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

CMD=tailscale
NAME="Tailscale"

pre_run

curl -fsSL https://tailscale.com/install.sh | sh

post_run

echo -e "\e[34m»»» 📜 \e[32mNOTE: Run 'sudo tailscale up' manually to authenticate and join your tailnet"
