#!/bin/bash
set -e

NAME="Flatpak Applications"
echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

# Ensure flatpak and flathub are set up
sudo apt install -y -q flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

apps=(
  com.google.Chrome
  com.calibre_ebook.calibre
  org.videolan.VLC
  com.github.geigi.cozy
  com.vixalien.sticky
  com.bishwasaha.Koncentro
)

for app in "${apps[@]}"; do
  echo -e "\e[34m  » \e[39mflatpak install $app\e[0m"
  flatpak install -y --noninteractive flathub "$app" || echo -e "\e[33m    ⚠ Failed: $app\e[0m"
done

echo -e "\n\e[34m»»» ✅ \e[32mFlatpak apps installed\e[0m"
