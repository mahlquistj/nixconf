{pkgs, ...}: {
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
    ripgrep

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
