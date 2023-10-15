#!/bin/bash
set -e

# Packages on top of base but for Laptop / Workstation only (not needed/necessary on servers)

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33mBase Laptop Packages\e[0m ..."

sudo apt-get update -y -qq
sudo apt-get install -y \
  build-essential \
  feh \
  conky \
  gnupg \
  pass \
  xcape \
  vlc \

sh ./node.sh

