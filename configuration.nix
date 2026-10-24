# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

let
  # Pinned nixpkgs-unstable, used to grab newer packages than the 26.05 stable
  # channel ships (e.g. terraform, which needs >=1.16 for some configs).
  pkgsUnstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/f20cd90e28fe0403873f473b29e42662cd86e8c4.tar.gz")
    { inherit (pkgs) system; config.allowUnfree = true; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."alex" = {
    isNormalUser = true;
    description = "Alex";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    # Terminal / shell
    kitty
    starship

    # Editors / IDEs
    neovim
    vscode

    # Browser
    google-chrome

    # Apps
    discord

    # Dev tooling
    git
    git-lfs
    openssl
    gh
    claude-code
    gnumake
    gcc
    dotnet-sdk_10
    nodejs
    (python3.withPackages (ps: [ ps.paho-mqtt ps.boto3 ps.cryptography ps.pip ]))
    postgresql

    # Kubernetes
    kubernetes-helm
    kubectl
    k9s
    pkgsUnstable.terraform

    # Hyprland / desktop
    hyprpaper
    mpvpaper
    yt-dlp
    hyprlock
    waybar
    wofi
    rofi
    hyprshot
    ranger
    wl-clipboard
    lua5_4

    # System monitoring / networking
    htop
    btop
    iftop
    ncdu # disk usage
    nmap
    iproute2
    lsof
    strace
    tcpdump

    # CLI utilities
    wget
    jq
    yq
    ripgrep
    fd
    bat
    unzip
    awscli2
    ssm-session-manager-plugin
    vagrant
    tree

    # Secrets / auth
    gnome-keyring
    pass

    # Media / hardware control
    playerctl
    brightnessctl

    # Screen recording
    (wrapOBS {
      plugins = with obs-studio-plugins; [
        obs-backgroundremoval
      ];
    })
  ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = false; # GUI for libvirtd, false = CLI only
  environment.variables.HELM_PLUGINS = "${pkgs.kubernetes-helmPlugins.helm-diff}";
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
  zramSwap.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
