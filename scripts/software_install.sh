#!/usr/bin/env bash

set -euo pipefail

echo "[INFO] Fedora environment setup starting..."

echo "[INFO] Enable DNF Starship"
sudo dnf copr enable atim/starship -y
echo "[INFO] Enable DNF Hyprland for Hyprland and Hyprlock"
sudo dnf copr enable lionheartp/Hyprland -y
echo "[INFO] Enable DNF VS Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
echo "[INFO] Add Terraform repo"
sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

sudo dnf makecache

install() {
  echo "[INSTALL] $1"
  sudo dnf install -y "$1"
}

check_bin() {
  command -v "$1" &>/dev/null
}

check_rpm() {
  rpm -q "$1" &>/dev/null
}

install_if_missing() {
  name="$1"
  bin="$2"
  pkg="$3"

  if check_bin "$bin"; then
    if check_rpm "$pkg"; then
      echo "[OK] $name (rpm native)"
    else
      echo "[OK] $name (non-rpm source)"
    fi
    return 0
  fi

  echo "[MISSING] $name -> installing..."
  install "$pkg"
}

data=$(yq -r '
  .tools[][]
  | [.name, .bin, .pkg]
  | @tsv
' ../tools.yaml)

while IFS=$'\t' read -r name bin pkg; do
  install_if_missing "$name" "$bin" "$pkg"
done <<< "$data"

# AI Install via NPM
npm install -g @github/copilot || true
npm install -g @google/gemini-cli || true
npm install -g @anthropic-ai/claude-code || true

if fc-list | grep -qi "JetBrainsMono Nerd"; then
  echo "[OK] Nerd Font already installed"
else
  echo "[INFO] Installing Nerd Font..."
  FONT_DIR="$HOME/.local/share/fonts"
  mkdir -p "$FONT_DIR"
  cd "$FONT_DIR"
  curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip
  rm -f JetBrainsMono.zip
  fc-cache -fv
fi

echo "[INFO] Installing Google Fonts..."
sudo dnf install google-noto-sans-fonts google-noto-emoji-fonts -y

echo "[INFO] Enable virtualization service for $USER"
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER

echo "[DONE] Setup complete."
