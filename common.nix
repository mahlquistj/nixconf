# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Include home-manager configuration
    ./home-manager.nix
  ];

  ## System configuration ##

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Disk encryption
    initrd.luks.devices."luks-058dec93-cc6c-4357-9bbf-e1843b3dafe4".device =
      "/dev/disk/by-uuid/058dec93-cc6c-4357-9bbf-e1843b3dafe4";
  };

  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Locale
  i18n = {
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "da_DK.UTF-8";
      LC_IDENTIFICATION = "da_DK.UTF-8";
      LC_MEASUREMENT = "da_DK.UTF-8";
      LC_MONETARY = "da_DK.UTF-8";
      LC_NAME = "da_DK.UTF-8";
      LC_NUMERIC = "da_DK.UTF-8";
      LC_PAPER = "da_DK.UTF-8";
      LC_TELEPHONE = "da_DK.UTF-8";
      LC_TIME = "da_DK.UTF-8";
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maj = {
    isNormalUser = true;
    description = "Mads Ahlquist Jensen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # System packages
  environment = {
    systemPackages = with pkgs; [
      # Essentials
      vim
      wget
      git
      curl
      nixd
      openssl
      bash
    ];
    variables = { EDITOR = "vim"; };
  };

  programs = { bash.enable = true; };

  services = {
    # OpenSSH
    openssh.enable = true;

    # Xserver
    xserver = {
      enable = true;
      xkb = {
        layout = "dk";
        variant = "";
      };
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  ## Nix Configuration ##
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
