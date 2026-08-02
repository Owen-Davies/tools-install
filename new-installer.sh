#!/usr/bin/env bash
#
# new-installer.sh <tool> [owner/repo] — scaffold a new installer script from
# _template_github.sh.
#
# Creates <tool>.sh next to the other installers, pre-filling CMD and NAME (and
# GITHUB if you pass owner/repo), then leaves the download line's __changeme__
# placeholders for you to complete. Refuses to overwrite an existing script.
#
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
TEMPLATE="$DIR/_template_github.sh"

usage() {
  cat <<EOF
Usage: $(basename "$0") <tool> [owner/repo]

  <tool>       name of the new installer (creates <tool>.sh; also used as CMD/NAME)
  owner/repo   optional GitHub repo to pre-fill GITHUB= (e.g. cli/cli)

Example:
  $(basename "$0") ripgrep BurntSushi/ripgrep
EOF
}

case "${1:-}" in
  -h|--help|"") usage; [[ -z "${1:-}" ]] && exit 2 || exit 0 ;;
esac

TOOL="${1%.sh}"
REPO="${2:-}"
DEST="$DIR/$TOOL.sh"

[[ -f "$TEMPLATE" ]] || { echo "Template not found: $TEMPLATE" >&2; exit 2; }
if [[ -e "$DEST" ]]; then
  echo "Refusing to overwrite existing $TOOL.sh" >&2
  exit 2
fi

# Start from the github template, then fill in what we safely can.
cp "$TEMPLATE" "$DEST"

# CMD and NAME default to the tool name; GITHUB only if a repo was supplied.
sed -i -E "s|^CMD=.*|CMD=$TOOL|" "$DEST"
sed -i -E "s|^NAME=.*|NAME=\"$TOOL\"|" "$DEST"
if [[ -n "$REPO" ]]; then
  sed -i -E "s|^GITHUB=.*|GITHUB=\"$REPO\"|" "$DEST"
fi

chmod +x "$DEST"

echo "Created $TOOL.sh from $(basename "$TEMPLATE")."
echo "Next:"
[[ -z "$REPO" ]] && echo "  - set GITHUB=\"owner/repo\""
echo "  - fix the download URL / tarball path (replace the __changeme__ placeholders)"
echo "  - test:   ./$TOOL.sh"
echo "  - add it to the README index (see _list.sh output)"
