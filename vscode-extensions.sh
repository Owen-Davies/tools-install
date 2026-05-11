#!/bin/bash
set -e

NAME="VS Code Extensions"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="${1:-"$SCRIPT_DIR/../dotfiles/install/vscode-extensions.txt"}"

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME\e[0m ..."

if [ ! -f "$EXTENSIONS_FILE" ]; then
  echo -e "\e[31mExtensions file not found: $EXTENSIONS_FILE\e[0m"
  exit 1
fi

count=0
while IFS= read -r ext; do
  [[ -z "$ext" || "$ext" == \#* ]] && continue
  echo -e "\e[34m  » \e[39mInstalling $ext\e[0m"
  code --install-extension "$ext" --force > /dev/null 2>&1 && count=$((count + 1)) || echo -e "\e[33m    ⚠ Failed: $ext\e[0m"
done < "$EXTENSIONS_FILE"

echo -e "\n\e[34m»»» ✅ \e[32mInstalled \e[33m$count\e[32m extensions\e[0m"
