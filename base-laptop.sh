#!/bin/bash
set -e

# Packages on top of base but for Laptop / Workstation only (not needed/necessary on servers)

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33mBase Laptop Packages\e[0m ..."

sudo apt-get update -y -qq
sudo apt-get install -y \
  build-essential \
  feh \
  conky-all \
  gnupg \
  pass \
  xcape \
  vlc

# node.sh is listed in profiles/base.txt, so it is not chained here any more.
# (It used to be `sh ./node.sh` -- wrong interpreter, and cwd-relative so it
# only worked when you happened to be standing in this directory.)

