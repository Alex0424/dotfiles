# Dotfiles

Configuration files for my system and applications


symlink path ./.config:

```
ln -s ~/dotfiles/.config ~/.config
```

previous command will link all these files:

```sh
.config
├── hypr
│   ├── hyprland.conf
│   └── hyprpaper.conf
├── rofi
│   ├── config.rasi
│   └── themes
│       └── DarkBlue.rasi
└── waybar
    ├── config
    └── style.css
```

## NixOS Install - Configuration as Code OS

- NixOS docs: https://nixos.org/manual/nixos/stable/
- NixOS video: https://youtu.be/61wGzIv12Ds

- Hyprland support docs: https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
- Hyprland support video: https://youtu.be/61wGzIv12Ds


### Step 1 - Install on flash drive

```sh
sudo dd if=~/Downloads/...nixos.iso of=/dev/sda bs=4M status=progress oflag=sync

sync

shutdown now
```

### Step 2 - boot in to usb stick

```
nmtui # connect to wifi
ping google.com # test
```

```sh
lsblk
# my disk is: nvme0n1 259:0 0 953.9G 0 disk
cfdisk /dev/nvme0n1
# chose gpt

new: 1G
type: EFI

new: 4G
type: swap

new: capture all memory by typing Enter 2x. my size is 948.9G
type: Linux filesystem
write: yes

quit

mkfs.ext4 -L nixos /dev/nvme0n1p3
mkswap -L swap /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p1

mount /dev/nvme0n1p3 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
swapon /dev/nvme0n1p2

# Mount EFI vars
mount -t efivarfs efivarfs /sys/firmware/efi/efivars/
```
```sh
lsblk
```
```sh
nvme0n1 953.9G      disk
- nvme0n1p1 1G      part  /mnt/boot
- nvme0n1p2 4G      part  [SWAP]
- nvme0n1p3 948.9G  part  /mnt
```
```sh
nixos-generate-config --root /mnt
```
```sh
vim /mnt/etc/nixos/configuration.nix
```
```
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
networking.networkmanager.enable = true;

networking.hostName = "nixos-btw"

time.timeZone = "Europe/Netherlands";

# For Hyperland add these configs:
services.xserver.enable = true;
services.displayManager.sddm.enable = true;
programs.hyprland.enable = true;
```
```
reboot
```

### Step 3

Boot into SSD and enjoy

### Add rofi and waybar

```
home.packages = with pkgs; [
  rofi
  waybar
];
```
```
sudo nixos-rebuild switch
```
