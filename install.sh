#!/usr/bin/env bash

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOFTWARE_INSTALL="$BASE_DIR/scripts/software_install.sh"
SYNC_SCRIPT="$BASE_DIR/scripts/sync_dotfiles.sh"
MIGRATE_SCRIPT=""

run_script() {
  local script_path="$1"
  local info_msg="$2"

  if [[ ! -f "$script_path" ]]; then
    echo "[ERROR] $(basename -- "$script_path") not found at: $script_path"
    exit 1
  fi

  echo "[INFO] $info_msg"
  "$script_path"
  echo "[DONE]"
}

install_software() {
  run_script "$SOFTWARE_INSTALL" "Installing software..."
}

sync_dotfiles() {
  run_script "$SYNC_SCRIPT" "Running dotfiles sync..."
}

migrate() {
  echo "[WARN] This option is currently unavailable"
  #run_script "$MIGRATE_SCRIPT" "Running dotfiles migration..."
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
  elif [[ "$answer" == "M" ]]; then
    migrate
  elif [[ "$answer" == "Q" ]]; then
    echo "[INFO] Bye!"
    exit 0
  else
    echo "[WARN] Invalid option"
  fi
  printf "\n"
done
