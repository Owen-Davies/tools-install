#!/bin/bash
set -e

# Basic base/xserver packages

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33mBase XServer Packages\e[0m ..."

sudo apt-get update -y -qq
sudo apt-get install -y \
  xinit \
  
