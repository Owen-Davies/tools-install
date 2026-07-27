#!/bin/bash
#
# Install a whole machine's worth of tools, chosen by machine profile.
# Replaces installeverything.sh, which was hardcoded to the laptop.
#
#   ./install-profile.sh                    auto-detect the profile
#   ./install-profile.sh headless           force one
#   ./install-profile.sh --profile wsl2     same thing, long form
#   ./install-profile.sh --dry-run          list what would run, install nothing
#   ./install-profile.sh --list             same as --dry-run
#
# Runs profiles/base.txt then profiles/<profile>.txt then hosts/<hostname>.txt.
# Individual failures are reported and the run continues; a `!script` line in a
# manifest is fatal. Exits non-zero if anything failed, so cloud-init and CI can
# actually tell.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=_lib.sh
source "$SCRIPT_DIR/_lib.sh"

DRY_RUN=0
PROFILE=""
SKIP_APT=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)   PROFILE="$2"; shift 2 ;;
    --profile=*) PROFILE="${1#*=}"; shift ;;
    --dry-run|--list) DRY_RUN=1; shift ;;
    --skip-apt-upgrade) SKIP_APT=1; shift ;;
    -h|--help)   sed -n '3,18p' "$0" | sed 's/^# \?//'; exit 0 ;;
    -*) echo "Unknown option: $1 (try --help)" >&2; exit 1 ;;
    *)  PROFILE="$1"; shift ;;
  esac
done

# --profile -> $DOTFILES_PROFILE -> ~/.dotfiles-profile -> detect.
# ~/.dotfiles-profile is the shared contract with the dotfiles repo: a plain
# file in $HOME, so neither repo has to know where the other is cloned.
[ -n "$PROFILE" ] || PROFILE="$(detect_profile)"

case "$PROFILE" in
  desktop|wsl2|headless|base) ;;
  *) echo "Unknown profile '$PROFILE' (expected: desktop, wsl2, headless, base)" >&2; exit 1 ;;
esac

HOSTSHORT="$(uname -n | cut -d. -f1)"

echo -e "\e[34m»»» 🚀 \e[32mTool install for profile \e[33m$PROFILE\e[32m on \e[33m$HOSTSHORT\e[0m"
[ "$DRY_RUN" = "1" ] && echo -e "\e[34m»»» \e[33mDRY RUN -- nothing will be installed\e[0m"
echo

declare -A SEEN=()
declare -a OK=() FAILED=() SKIPPED=()

run_manifest() {
  local mf="$1"
  if [ ! -f "$mf" ]; then
    return 0
  fi

  echo -e "\e[34m»»» 📋 \e[36mmanifest: ${mf#"$SCRIPT_DIR"/}\e[0m"

  local line script args must
  while IFS= read -r line || [ -n "$line" ]; do
    line="${line%%#*}"
    line="$(echo "$line" | xargs)"
    [ -z "$line" ] && continue

    must=0
    if [[ "$line" == '!'* ]]; then must=1; line="${line#!}"; fi

    script="${line%% *}"
    args="${line#"$script"}"

    if [ -n "${SEEN[$script]:-}" ]; then
      echo -e "\e[34m»»» ⏭  \e[90m$script already run, skipping duplicate\e[0m"
      continue
    fi
    SEEN[$script]=1

    if [ ! -f "$SCRIPT_DIR/$script" ]; then
      echo -e "\e[31m  ✖ $script does not exist\e[0m"
      FAILED+=("$script (missing)")
      continue
    fi

    if [ "$DRY_RUN" = "1" ]; then
      printf '    would run %s%s\n' "$script" "$args"
      OK+=("$script")
      continue
    fi

    echo -e "\e[34m»»» ▶ \e[33mRunning $script$args\e[0m"
    # shellcheck disable=SC2086
    if bash "$SCRIPT_DIR/$script" $args; then
      OK+=("$script")
    else
      echo -e "\e[31m  ✖ $script failed\e[0m"
      FAILED+=("$script")
      if [ "$must" = "1" ]; then
        echo -e "\e[31m»»» 💥 $script is marked required, aborting\e[0m"
        exit 1
      fi
    fi
  done < "$mf"
}

if [ "$DRY_RUN" = "0" ] && [ "$SKIP_APT" = "0" ]; then
  echo -e "\e[34m»»» 📦 \e[32mRefreshing apt\e[0m"
  sudo apt-get update -y -qq && sudo apt-get upgrade -y
fi

run_manifest "$SCRIPT_DIR/profiles/base.txt"
[ "$PROFILE" != "base" ] && run_manifest "$SCRIPT_DIR/profiles/$PROFILE.txt"
run_manifest "$SCRIPT_DIR/hosts/$HOSTSHORT.txt"

#
# Summary. installeverything.sh swallowed every failure into scrollback and
# always exited 0, so a half-provisioned machine looked like a clean run.
#
echo
echo -e "\e[34m»»» 📊 \e[32mOK: ${#OK[@]}   \e[31mFAILED: ${#FAILED[@]}\e[0m"
if [ ${#FAILED[@]} -gt 0 ]; then
  printf '\e[31m  ✖ %s\e[0m\n' "${FAILED[@]}"
  echo -e "\n\e[33mRe-run individual scripts to see the full error.\e[0m"
  exit 1
fi

echo -e "\n\e[34m»»» ✅ \e[32mAll done!\e[0m"
