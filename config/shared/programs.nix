{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["beekeeper-studio-5.3.4"];
  };

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
    vhs
    vlc

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
    codex

    # Other
    beekeeper-studio
    scc
    cava
    ncspot
    neofetch
    gnome.gvfs # fix for swaync mpris widget
  ];

  # Flatpak
  services.flatpak.enable = true;

  # SSH
  services = {
    openssh.enable = true;
  };
}
