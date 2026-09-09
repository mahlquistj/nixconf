{
  pkgs,
  inputs,
  ...
}: let
  # Wrap chiaki-ng to prevent kvantum QML style crash
  # Kvantum provides a QtWidgets style plugin but no QML module,
  # causing chiaki-ng (a Qt Quick app) to fail loading Main.qml
  chiaki-ng-wrapped = pkgs.symlinkJoin {
    name = "chiaki-ng";
    paths = [pkgs.chiaki-ng];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/chiaki \
        --unset QT_STYLE_OVERRIDE \
        --unset QT_QPA_PLATFORMTHEME
    '';
  };
in {
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

  programs = {
    nix-ld = {
      enable = true;

      libraries = with pkgs; [
        stdenv.cc.cc.lib

        xorg.libSM
        xorg.libICE
        xorg.libX11
        xorg.libXext

        freetype
        libxcb

        xcbutil
        xcbutilkeysyms
        xcb-util-cursor

        libxkbcommon

        glib
        cairo
        pango
        harfbuzz
        fontconfig
        expat

        curl
        zstd
      ];
    };
  };

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
    zenity
    sops
    whois
    exfat

    # DAW
    bitwig-studio
    reaper
    yabridge
    yabridgectl

    # C
    gcc

    # Display management
    brightnessctl

    # Theming
    catppuccin-papirus-folders
    phinger-cursors

    # AI
    claude-code
    codex

    # Other
    chiaki-ng-wrapped
    easyeffects
    obs-studio
    scc
    cava
    ncspot
    fastfetch
    gnome.gvfs # fix for swaync mpris widget
    webkitgtk_6_0
    ffmpeg-full
    # zulip
  ];

  # SSH
  services = {
    openssh.enable = true;
  };
}
