#!/bin/bash
# Kept for muscle memory. The real entrypoint is install-profile.sh, which picks
# the right tool set for the machine instead of assuming it is the laptop.
#
# This wrapper forces the desktop profile, which is what this script always did.
# For WSL2 or the droplet, run install-profile.sh directly (or with no argument
# and let it detect).
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "\e[33m»»» installeverything.sh is now a wrapper for: install-profile.sh desktop\e[0m\n"
exec bash "$SCRIPT_DIR/install-profile.sh" desktop "$@"
