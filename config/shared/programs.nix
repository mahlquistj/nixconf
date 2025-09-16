{pkgs, ...}: {
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
    keymapp
    nettools
    wev # Keyboard debugging
    killall
    zip
    unzip

    # DAW
    bitwig-studio

    # C
    gcc

    # Display management
    brightnessctl

    # Theming
    magnetic-catppuccin-gtk
    catppuccin-papirus-folders
    phinger-cursors

    # AI
    claude-code

    # Other
    scc
    cava
    ncspot
    neofetch
    gnome.gvfs # fix for swaync mpris widget
  ];

  services = {
    openssh.enable = true;
  };
}
