{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  qt.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Essentials
    vim
    wget
    git
    curl
    nixd
    openssl
    home-manager
    wev # Keyboard debugging

    # Display management
    brightnessctl

    # Theming
    magnetic-catppuccin-gtk
    catppuccin-papirus-folders

    # Utilities
    alejandra # nix formatter

    # Other
    neofetch
    phinger-cursors

  ];

  services = {
    # OpenSSH
    openssh.enable = true;
  };
}
