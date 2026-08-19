#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# shellcheck disable=SC1091
source "$DIR"/_lib.sh

NAME="x13 extra apt packages"
VERSION="n/a"
CMD=true

# Everything below is plain-apt-installable from Ubuntu's own repos -- no
# vendor apt repo, no .deb download, no PPA. Computed as: `dpkg -l` manually-
# installed packages on the old x13 GNOME install, minus anything already
# covered by profiles/base.txt or profiles/desktop.txt, minus GNOME-shell-only
# packages (extensions/portals/search providers with nothing to attach to once
# gnome-shell itself is gone), minus base-system/bootloader/kernel packages the
# installer or the HWE kernel meta package already own.
#
# NOT here, because they need a vendor apt repo, a direct .deb, or a PPA and
# get their own script instead: virtualbox.sh, steam.sh, microsoft-edge.sh,
# teamviewer.sh, zoom.sh, obsidian.sh, minecraft-launcher.sh,
# appimagelauncher.sh, tailscale.sh, dwm.sh/st.sh/dmenu.sh, lightdm.sh.
#
# NOT scripted at all -- no apt repo or install method confirmed with enough
# confidence to automate; install these by hand after first boot if wanted:
#   claude-desktop   -- no official Anthropic Linux package; third-party build
#                        (e.g. github.com/aaddrick/claude-desktop-debian)
#   tradingview      -- no verified apt/repo source
#   balena-etcher    -- vendor repo details not confirmed against current docs
#   vagrant          -- needs HashiCorp's apt repo (apt.releases.hashicorp.com)
#   librewolf        -- needs LibreWolf's own apt repo (deb.librewolf.net)
#   powershell       -- needs the Microsoft repo (packages.microsoft.com),
#                        same shape as microsoft-edge.sh if you want to script it
#   chromium-browser -- Ubuntu's apt package is just a snap-transitional stub;
#                        snap-apps.sh already installs the real chromium snap

pre_run

# Steam (via steam.sh) drags in ~35 :i386 runtime libs (VA-API/GL/X11) as
# ordinary apt dependencies once multiverse+i386 are enabled there. Not
# listed individually here.

pkgs=(
  # --- security / crypto / disk -------------------------------------------
  ca-certificates
  cryptsetup
  dislocker
  dkms
  dmg2img
  exfatprogs
  lvm2
  oathtool
  dirmngr
  pass-extension-update
  pass-simple
  pcscd
  tpm2-tools
  yubikey-manager
  yubikey-manager-qt
  yubikey-personalization

  # --- dev / build toolchain -----------------------------------------------
  # Purpose not individually re-verified against current use -- carried over
  # as scanned from the old install (looks like graphics/compositor and media
  # dev headers: mesa/EGL/wlroots-shaped libs, ffmpeg, SDL2, Vulkan).
  clang
  cmake
  cmake-extras
  extrepo
  gettext
  gettext-base
  glslang-tools
  libavcodec-dev
  libavformat-dev
  libavutil-dev
  libdrm-dev
  libegl-dev
  libegl1-mesa-dev
  libffi-dev
  libfontconfig-dev
  libgbm-dev
  libgdm-dev
  libgtk-3-dev
  libinput-dev
  libnss3-tools
  libopenal-dev
  libpixman-1-dev
  libre2-dev
  libsdl2-dev
  libseat-dev
  libssl-dev
  libstdc++-12-dev
  libsystemd-dev
  libtomlplusplus3t64
  libudev-dev
  libvirt-dev
  libxcb-composite0-dev
  libxcb-dri3-dev
  libxcb-ewmh2
  libxcb-ewmh-dev
  libxcb-icccm4-dev
  libxcb-present-dev
  libxcb-render-util0-dev
  libxcb-res0-dev
  libxcb-xinput-dev
  libxkbcommon-dev
  libxkbcommon-x11-dev
  libxkbregistry-dev
  libxml2-dev
  meson
  ninja-build
  pkg-config
  seatd

  # --- CLI tools -------------------------------------------------------------
  ansible-core
  fd-find
  file
  grep
  p7zip-full
  python3-netifaces
  python3-pip
  python3-venv
  qemu-system-x86
  ripgrep
  silversearcher-ag
  tmux
  universal-ctags
  vim-gtk3
  zsh

  # --- GUI apps (plain Ubuntu repo, X11-compatible, no gnome-shell needed) ---
  gnome-terminal
  gparted
  qdirstat
  remmina
  remmina-plugin-rdp
  rpi-imager
  syncthing
  tomboy-ng
  zbar-tools
  zenity

  # --- fonts / locale / codecs ------------------------------------------------
  fontconfig
  fonts-liberation
  language-pack-en
  language-pack-en-base
  libcanberra-gtk3-module
  libcanberra-gtk-module
  libgles2
  thunderbird-locale-en
  thunderbird-locale-en-gb
  thunderbird-locale-en-us

  # --- flatpak/xdg portal plumbing (dwm is X11 -- gtk backend, not gnome) ---
  flatpak
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-utils

  # --- remote access -----------------------------------------------------
  openssh-server
  openssl
)

sudo apt-get update -y -qq
sudo apt-get install -y "${pkgs[@]}"

echo -e "\n\e[34m»»» ✅ \e[32m${#pkgs[@]} extra packages installed\e[0m"
