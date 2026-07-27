#!/bin/bash

# All scripts should source this file

get_latest_release() {
  if [ $# -lt 2 ]; then PREFIX="v"; else PREFIX=$2; fi

  curl --silent "https://api.github.com/repos/$1/releases/latest" |
  grep '"tag_name":' | sed -E "s/.*\"$PREFIX([^\"]+)\".*/\1/"
}

pre_run() {
  echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME \e[35mv$VERSION\e[0m ..."
  if [ -z "$INSTALL_DIR" ]; then return; fi

  echo -e "\e[34m»»» 📂 \e[32mTarget directory for binary: \e[35m$INSTALL_DIR"

  if [[ :$PATH: == *:"$INSTALL_DIR":* ]] ; then
    echo -e "\e[34m»»» ✅ \e[32mPATH is good"
  else
    echo -e "\e[34m»»» 💥 \e[31mInstall directory in not in PATH. Temporarily adding it!"
    echo -e "\e[34m»»» 📢 \e[31mNOTE! Amend your shell startup scripts to make this change permanent:\n\t\e[37mexport PATH=\$PATH:$INSTALL_DIR"
    export PATH="$PATH:$INSTALL_DIR"
  fi

  mkdir -p "$INSTALL_DIR"
}

post_run() {
  VERFLAG=${1:-"--version"}
  # shellcheck disable=all
  echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
  # shellcheck disable=all
  echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD $VERFLAG)"
}

apt_version() {
  apt-cache policy "$1" | grep Candidate: | cut -b 14-99
}

random_fruit() {
  fruits=("🍎" "🍊" "🍋" "🍌" "🍉" "🍇" "🍓" "🍒" "🍑" "🍍" "🥝" "🍅" "🍆" "🥑" "🥦" "🥒" "🥬" "🥭" "🥔" "🥕" "🌽" "🌶" "🍎" "🌶️" "🫐" "🥥" "🍄")
  echo "${fruits[$((RANDOM % ${#fruits[@]}))]}"
}

#
# ─── Capability guards ────────────────────────────────────────────────────────
#
# The profile manifest decides WHAT to run; these let a script decline when the
# machine cannot support it. A manifest mistake then degrades to a skip instead
# of a failure. Call them right after NAME= is set.
#
# NOTE they exit 0, not 1: a skip is not a failure, and install-profile.sh
# counts non-zero exits as errors in its summary.
#

skip() {
  echo -e "\e[34m»»» ⏭  \e[33mSkipping ${NAME:-$(basename "$0")}: $1\e[0m"
  exit 0
}

require_no_wsl() {
  if [ -n "${WSL_DISTRO_NAME:-}" ] || [ -n "${WSL_INTEROP:-}" ] || grep -qi microsoft /proc/version 2>/dev/null; then
    skip "not supported under WSL"
  fi
}

require_systemd() {
  [ -d /run/systemd/system ] || skip "no systemd on this machine"
}

require_gui() {
  if [ ! -d /usr/share/xsessions ] && [ ! -d /usr/share/wayland-sessions ]; then
    skip "no GUI on this machine"
  fi
}

require_snap() {
  command -v snap > /dev/null 2>&1 || skip "snapd not available"
}

require_flatpak() {
  command -v flatpak > /dev/null 2>&1 || skip "flatpak not available"
}

# Debian architecture name, for apt sources and release asset URLs.
# Most scripts in this repo still hardcode amd64; use this in new ones.
arch_deb() {
  case "$(uname -m)" in
    x86_64)  echo amd64 ;;
    aarch64) echo arm64 ;;
    armv7l)  echo armhf ;;
    *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
  esac
}

# Idempotent clone. A bare `git clone` into a fixed directory fails on the
# second run, which is what stopped several of these scripts being re-runnable.
git_clone_or_pull() {
  if [ -d "$2/.git" ]; then
    git -C "$2" pull --ff-only -q 2>/dev/null || true
  else
    mkdir -p "$(dirname "$2")"
    git clone -q --depth=1 "$1" "$2"
  fi
}

# Machine class, matching dotfiles/profile.sh.
#
# DUPLICATED ON PURPOSE. tools-install is documented as standalone, so it must
# not require the dotfiles repo to be cloned next to it -- vscode-extensions.sh's
# "../dotfiles/..." assumption is the cautionary example already in this repo.
# Twenty lines of pure logic is cheaper than coupling two independent clones.
# Keep in sync with dotfiles/profile.sh:dotfiles_detect_profile (`make check`).
detect_profile() {
  [ -n "${DOTFILES_PROFILE:-}" ] && { echo "${DOTFILES_PROFILE:-}"; return 0; }

  if [ -r "$HOME/.dotfiles-profile" ]; then
    read -r _dp < "$HOME/.dotfiles-profile"
    case "$_dp" in ''|\#*) ;; *) echo "$_dp"; return 0 ;; esac
  fi

  if [ -n "${WSL_DISTRO_NAME:-}" ] || [ -n "${WSL_INTEROP:-}" ] || [ -e /run/WSL ] \
     || grep -qi microsoft /proc/version 2>/dev/null; then
    echo wsl2; return 0
  fi

  if [ -f /.dockerenv ] || [ -n "${CODESPACES:-}" ] || [ -n "${REMOTE_CONTAINERS_IPC:-}" ]; then
    echo headless; return 0
  fi

  if [ -n "${WAYLAND_DISPLAY:-}" ] || [ -n "${DISPLAY:-}" ] \
     || [ -d /usr/share/wayland-sessions ] || [ -d /usr/share/xsessions ]; then
    echo desktop; return 0
  fi

  echo headless
}