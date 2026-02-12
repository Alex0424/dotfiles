# NixOS

lsblk
#sda 57.8G disk 
#├─sda1 57.8G part /media/alex/WIN11_2025 
#└─sda2 1M part /media/alex/UEFI_NTFS
sudo umount /dev/sda1
sudo umount /dev/sda2

sudo dd if=~/Downloads/...nixos.iso of=/dev/sda bs=4M status=progress oflag=sync
sync

# restart
# boot in to usb stick

nmtui # connect to wifi
ping nixos.org # check connection
sudo -i
parted /dev/nvme0n1 -- mklabel gpt
parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
parted /dev/nvme0n1 -- set 1 esp on
parted /dev/nvme0n1 -- mkpart primary ext4 512MiB 100%
lsblk
# nvme0n1 259:0 0 953.9G 0 disk
# -nvme0n1p2 259:1 953.4G 0 part
# -nvme0n1p1 259:2 511M 0 part

mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2

mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

nixos-generate-config --root /mnt

vim /mnt/etc/nixos/configuration.nix
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;
time.timeZone = "Europe/Netherlands";
networking.networkmanager.enable = true;

users.users.alice = { # REPLACE alice with your user e.g.: alex <--- !!!
  isNormalUser = true;
  extraGroups = [ "wheel" ];
  packages = with pkgs; [
  ];
};

nixos-install
reboot
