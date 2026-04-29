#!/usr/bin/env bash

set -e

#export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/runtime-$USER}"
#mkdir -p "$XDG_RUNTIME_DIR"
#chmod 700 "$XDG_RUNTIME_DIR"

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

# Core CLI utilities
install_if_missing "Git" "git" "git"
install_if_missing "Git LFS" "git-lfs" "git-lfs"
install_if_missing "GitHub CLI" "gh" "gh"
install_if_missing "Curl" "curl" "curl"
install_if_missing "Wget" "wget" "wget"
install_if_missing "JQ" "jq" "jq"
install_if_missing "YQ" "yq" "yq"
install_if_missing "ripgrep" "rg" "ripgrep"
install_if_missing "fd" "fd" "fd-find"
install_if_missing "bat" "bat" "bat"
install_if_missing "Unzip" "unzip" "unzip"
install_if_missing "AWS CLI" "aws" "awscli"
install_if_missing "Make" "make" "make"
install_if_missing "Node.js" "node" "nodejs"
install_if_missing "npm" "npm" "npm"


# IDE
install_if_missing "Neovim" "nvim" "neovim"
install_if_missing "VS Code" "code" "code"

# Hyprland
install_if_missing "Kitty" "kitty" "kitty"
install_if_missing "Starship" "starship" "starship"
install_if_missing "Waybar" "waybar" "waybar"
install_if_missing "Rofi" "rofi" "rofi"
install_if_missing "Wofi" "wofi" "wofi"
install_if_missing "Hyprland" "hyprland" "hyprland"
install_if_missing "Hyprlock" "hyprlock" "hyprlock"
install_if_missing "Ranger" "ranger" "ranger"

# VM, Containers, K8S
install_if_missing "Docker" "docker" "docker"
install_if_missing "Docker Compose" "docker" "docker-compose"
install_if_missing "Kubectl" "kubectl" "kubectl"
install_if_missing "K9S" "k9s" "k9s"
install_if_missing "Helm" "helm" "helm"
install_if_missing "Terraform" "terraform" "terraform"
install_if_missing "Virtual Machine Manager" "virt-manager" "virt-manager"
install_if_missing "Vagrant" "vagrant" "vagrant"

# Languages
install_if_missing ".NET" "dotnet" "dotnet-sdk-10.0"
install_if_missing "Java JDK" "javac" "java-latest-openjdk-devel"
install_if_missing "C++" "g++" "gcc-c++"
# Python, C, exist by default

# debugging
install_if_missing "SS (netstat replacement)" "ss" "iproute"
install_if_missing "Lsof" "lsof" "lsof"
install_if_missing "Strace" "strace" "strace"
install_if_missing "Tcpdump" "tcpdump" "tcpdump"

# Observability
install_if_missing "htop" "htop" "htop"
install_if_missing "btop" "btop" "btop"
install_if_missing "iftop" "iftop" "iftop"
install_if_missing "Disk usage" "ncdu" "ncdu"
install_if_missing "Network tool" "nmap" "nmap"

# Security
install_if_missing "Pass" "pass" "pass"

# AI
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
