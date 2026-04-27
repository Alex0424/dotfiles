# Dotfiles

A centralized collection of configuration files for my Linux systems.

## Preview

### Hyprland

![Hyprland](./images/hyprland.png)

### Waybar

![Waybar](./images/waybar.png)

### Neovim

![Neovim](./images/nvim.png)

### Wofi

![Wofi](./images/wofi.png)

## Requirements

The following software versions (or newer) are required for full compatibility:

```conf
hyprland >= 0.51.1
kitty    >= 0.43.1
starship >= 1.21.1
nvim     >= 0.12.0 (Neovim)
code     >= 1.116.0 (Visual Studio Code)
waybar   >= 0.13.0
wofi     >= 1.5.3
rofi    >= 1.7.9
ranger   >= 1.9.4
hyprlock >= 0.9.2
neardfont >= 3.0.0
```

## Installation

### Script

```sh
./install.sh
```

### Manual Installation

#### 1. Validate repository

⚠️ Make sure you are inside the correct repository before proceeding.

Run this before executing any commands:

```sh
[ -f .dotfiles-root ] || echo "ERROR: not in dotfiles repository, do not continue!"
repo_path=$(pwd)
```

#### 2. (A) Sync configuration to your system

This method links the repository configuration files into your local system using symlinks.

```sh
mkdir -p "$HOME/.config-backup"
cp -r "$HOME/.config/<file>" "$HOME/.config-backup/" 2>/dev/null || true

rm -rf -- "$HOME/.config/<file>"
ln -s "$repo_path/<file>" "$HOME/.config/<file>"
```

Do this for each file you want to sync

#### 2. (B) Migrate your existing configuration

This method copies your current system configuration into this repository for version control:

```sh
rm -rf -- "$repo_path/<file>"
cp -r "$HOME/.config/<file>" "$repo_path"
```

Do this for each file you want to migrate
