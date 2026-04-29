#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOFTWARE_INSTALL="$BASE_DIR/scripts/software_install.sh"
SYNC_SCRIPT="$BASE_DIR/scripts/sync_dotfiles.sh"
MIGRATE_SCRIPT=""

install_software() {
  if [[ ! -f "$SOFTWARE_INSTALL" ]]; then
    echo "[ERROR] software_install.sh not found at $SOFTWARE_INSTALL"
    exit 1
  fi

  echo "[INFO] Installing software..."
  "$SOFTWARE_INSTALL"
  echo "[DONE]"
}

sync_dotfiles() {
  if [[ ! -f "$SYNC_SCRIPT" ]]; then
    echo "[ERROR] Sync_dotfiles.sh not found at $SYNC_SCRIPT"
    exit 1
  fi

  echo "[INFO] Running dotfiles sync..."
  "$SYNC_SCRIPT"
  echo "[DONE]"
}

while :
do
  echo "=== ✨ Menu ✨ ==="
  echo "[A] Install all software"
  echo "[S] Sync dotfiles"
  echo "[M] Migrate dotfiles (coming soon)"
  echo "[Q] Quit"
  read -p "Choice: " answer
  answer=${answer:-n}
  answer=${answer^^}
  if [[ "$answer" == "A" ]]; then
    install_software
  elif [[ "$answer" == "S" ]]; then
    sync_dotfiles
  elif [[ "$answer" == "Q" ]]; then
    echo "[INFO] Bye!"
    exit 0
  else
    echo "[WARN] Invalid option"
  fi
  printf "\n"
done

