{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "beekeeper-studio-5.5.3"
      "dotnet-runtime-8.0.23"

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
    nemo-with-extensions
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
    obs-studio
    scc
    cava
    ncspot
    fastfetch
    gnome.gvfs # fix for swaync mpris widget
    # zulip
  ];

  # SSH
  services = {
    openssh.enable = true;
  };
}
