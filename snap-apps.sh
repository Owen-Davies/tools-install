#!/bin/bash
set -e

NAME="Snap Applications"
echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

# User-installed snaps (system runtimes are auto-installed as dependencies)
snaps=(
  chromium
  clockify-cli
  firefox
  thunderbird
)

for snap in "${snaps[@]}"; do
  echo -e "\e[34m  » \e[39msnap install $snap\e[0m"
  sudo snap install "$snap" || echo -e "\e[33m    ⚠ Failed: $snap\e[0m"
done

echo -e "\n\e[34m»»» ✅ \e[32mSnap apps installed\e[0m"
