#!/bin/bash 
set -e

VERSION=${1:-"0.0.0"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
NAME=X2Go

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME v$VERSION\e[0m ..."

# INSTALL STEPS HERE

sudo apt-get update
sudo apt install x2goserver x2goserver-xsession
sudo apt install xfce4

## rename hostname in /etc/hostname

echo -e "\n\e[34m»»» 💾 \e[32mInstalled"

