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
kitty    >= 0.43.1
ranger   >= 1.9.4
hyprland >= 0.51.1
nvim     >= v0.12.0 (Neovim)
code     >= 1.116.0 (Visual Studio Code)
waybar   >= v0.13.0
wofi     >= v1.5.3
hyprlock >= v0.9.2
```

## Installation

### Script

```sh
./install.sh
```

### Manual Installation

#### Sync Configuration to Your System

This method links the repository configurations into your local system:

```sh
repo_path=$(pwd)

rm -rf -- "$HOME/.config/hypr"
rm -rf -- "$HOME/.config/nvim"
rm -rf -- "$HOME/.config/rofi"
rm -rf -- "$HOME/.config/waybar"

ln -s "$repo_path/hypr" "$HOME/.config/hypr"
ln -s "$repo_path/nvim" "$HOME/.config/nvim"
ln -s "$repo_path/rofi" "$HOME/.config/rofi"
ln -s "$repo_path/waybar" "$HOME/.config/waybar"
```

#### Migrate Your Existing Configuration

This method copies your current system configuration into this repository for version control:

```sh
repo_path=$(pwd)

rm -rf -- "$repo_path/hypr"
cp -r "$HOME/.config/hypr" "$repo_path"

rm -rf -- "$repo_path/nvim"
cp -r "$HOME/.config/nvim" "$repo_path"

rm -rf -- "$repo_path/rofi"
cp -r "$HOME/.config/rofi" "$repo_path"

rm -rf -- "$repo_path/waybar"
cp -r "$HOME/.config/waybar" "$repo_path"
```
