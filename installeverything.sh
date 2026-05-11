#!/bin/bash
# Full system setup script - run after a fresh Ubuntu install
# Usage: ./installeverything.sh
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "\e[34m»»» 🚀 \e[32mFull system install starting...\e[0m\n"

run() {
  echo -e "\e[34m»»» ▶ \e[33mRunning $1\e[0m"
  bash "$1" || echo -e "\e[31m  ✖ $1 failed, continuing...\e[0m"
}

# System base
sudo apt update -y && sudo apt upgrade -y

run base.sh
run base-laptop.sh

# Languages & runtimes
run golang.sh
run rust.sh
run node.sh
run node-tools.sh
run dotnet.sh
run deno.sh

# Container & orchestration
run docker.sh
run kubectl.sh
run helm.sh
run k9s.sh
run kind.sh
run kube-tools.sh
run kustomize.sh

# Infrastructure & cloud
run terraform.sh
run tflint.sh
run az-cli.sh
run azcopy.sh
run azbrowse.sh
run azd.sh

# GitOps & CI
run flux.sh
run gh.sh
run act.sh

# Dev tools
run fzf.sh
run vim.sh
run tmux.sh
run keyd.sh
run just.sh
run air.sh
run golangci-lint.sh
run mkcert.sh

# Security
run yubikey.sh
run pass.sh
run sops.sh

# Applications
run code.sh
run vscode-extensions.sh
run snap-apps.sh
run flatpak-apps.sh
run python-tools.sh

echo -e "\n\e[34m»»» ✅ \e[32mAll done!\e[0m"
