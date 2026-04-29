#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOFTWARE_INSTALL="$BASE_DIR/scripts/software_install.sh"
SYNC_SCRIPT="$BASE_DIR/scripts/sync_dotfiles.sh"

if [[ ! -f "$SOFTWARE_INSTALL" ]]; then
  echo "[ERROR] software_install.sh not found at $SOFTWARE_INSTALL"
  exit 1
fi

echo "[INFO] Software installation"
echo "(Skip this if you only want to sync dotfiles)"
echo

read -p "[Q&A] Install all software? (y/n): " answer
answer=${answer:-n}

if [[ "$answer" != "y" ]]; then
  echo "[INFO] Skipping software installation"
else
  echo "[INFO] Installing software..."
  bash "$SOFTWARE_INSTALL"
fi

if [[ ! -f "$SYNC_SCRIPT" ]]; then
  echo "[ERROR] Sync_dotfiles.sh not found at $SYNC_SCRIPT"
  exit 1
fi
echo "[INFO] Running dotfiles sync..."
"$SYNC_SCRIPT"

echo "[DONE]"
