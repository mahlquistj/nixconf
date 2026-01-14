{pkgs, ...}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.3.4"

      # Citrix workspace
      "libsoup-2.74.3"
      "libxml2-2.13.8"
    ];
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
    unrar
    vhs
    vlc
    ripgrep

    obs-studio

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
    antigravity

    # Other
    beekeeper-studio
    scc
    cava
    ncspot
    neofetch
    gnome.gvfs # fix for swaync mpris widget
  ];

  # SSH
  services = {
    openssh.enable = true;
  };
}
