#!/usr/bin/env bash
#
# check-updates.sh — batch "installed vs latest" across the GitHub-based
# installer scripts in this repo.
#
# Each github installer sets GITHUB="owner/repo" and gets its latest version
# from _lib.sh's get_latest_release (the GitHub "releases/latest" tag). This
# reads that same GITHUB value from every installer, fetches the latest tag the
# same way, then compares against whatever version of CMD is currently on PATH.
#
# GitHub's unauthenticated API allows only 60 requests/hour and this repo has
# ~40 github installers — export GITHUB_TOKEN (or GH_TOKEN) to authenticate and
# avoid rate limiting. Pass tool names to check only a subset.
#
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
# shellcheck disable=SC1091
source "$DIR/_lib.sh"

usage() {
  cat <<EOF
Usage: $(basename "$0") [-h] [tool ...]

Compares the installed version of each GitHub-based installer's CMD against the
latest GitHub release. With no args, checks every github installer; otherwise
only the named ones (e.g. 'gh k9s terraform', with or without a .sh suffix).

Set GITHUB_TOKEN or GH_TOKEN to avoid GitHub API rate limits.
EOF
}
[[ "${1:-}" == "-h" || "${1:-}" == "--help" ]] && { usage; exit 0; }

# Latest release tag, mirroring _lib.sh:get_latest_release but adding an auth
# header when a token is present (the repo's plain get_latest_release cannot).
TOKEN="${GITHUB_TOKEN:-${GH_TOKEN:-}}"
latest_tag() {
  local repo="$1" auth=()
  [[ -n "$TOKEN" ]] && auth=(-H "Authorization: Bearer $TOKEN")
  curl --silent "${auth[@]}" "https://api.github.com/repos/$repo/releases/latest" \
    | grep '"tag_name":' | sed -E 's/.*"tag_name": *"v?([^"]+)".*/\1/'
}

# Best-effort installed version: run CMD with a version flag and pull the first
# semver-looking token out of the output.
installed_version() {
  local cmd="$1" out="" flag
  command -v "$cmd" >/dev/null 2>&1 || { echo ""; return; }
  for flag in --version version -v -V; do
    if out="$("$cmd" "$flag" 2>&1)"; then break; fi
    out=""
  done
  printf '%s\n' "$out" | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1
}

# Which installers to check.
declare -a scripts=()
if [[ "$#" -gt 0 ]]; then
  for name in "$@"; do
    f="$DIR/${name%.sh}.sh"
    if [[ -f "$f" ]]; then scripts+=("$f"); else echo "No such installer: ${name%.sh}.sh" >&2; fi
  done
else
  for f in "$DIR"/[a-z]*.sh; do scripts+=("$f"); done
fi

[[ -z "$TOKEN" && "$#" -eq 0 ]] && echo "(no GITHUB_TOKEN set — may hit GitHub's 60 req/hr limit)" >&2

printf '%-22s %-14s %-14s %s\n' "TOOL" "INSTALLED" "LATEST" "STATUS"
printf '%-22s %-14s %-14s %s\n' "----" "---------" "------" "------"

updates=0
checked=0
for f in "${scripts[@]}"; do
  repo=$(grep -m1 -E '^GITHUB=' "$f" | sed -E 's/^GITHUB=["'\'']?([^"'\'' ]+).*/\1/')
  [[ -z "$repo" || "$repo" == *__changeme__* ]] && continue   # not a github installer
  cmd=$(grep -m1 -E '^CMD=' "$f" | sed -E 's/^CMD=["'\'']?([^"'\'' ]+).*/\1/')
  [[ -z "$cmd" ]] && cmd=$(basename "$f" .sh)

  checked=$((checked + 1))
  latest=$(latest_tag "$repo" || true)
  installed=$(installed_version "$cmd" || true)

  if [[ -z "$latest" ]]; then
    status="? (no release / rate-limited)"
  elif [[ -z "$installed" ]]; then
    status="not installed"
  elif [[ "$installed" == "$latest" ]]; then
    status="up to date"
  else
    status="UPDATE -> $latest"
    updates=$((updates + 1))
  fi

  printf '%-22s %-14s %-14s %s\n' "$(basename "$f" .sh)" "${installed:-–}" "${latest:-–}" "$status"
done

echo ""
echo "Checked $checked github installer(s); $updates update(s) available."
