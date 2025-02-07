{ pkgs, sysOptions, osConfig, ... }:

{
  imports = [
    ./firefox.nix
    ./fish.nix
    ./ghostty.nix
    ./hyprland.nix
    ./rofi.nix
    ./spotify.nix
    ./starship.nix
    ./waybar.nix
  ];

  home = {
    username = "maj";
    homeDirectory = "/home/maj";
    stateVersion = osConfig.system.stateVersion;

    packages = with pkgs; [
      # Utils
      jq # CLI JSON parsing
      eza # `ls` substitute

      # Management
      nemo # File manager

      # Screenshotting
      hyprshot

      # Social
      discord
    ];

    # Files
    file = {
      # Cursors
      ".icons/" = {
        source = ../../media/.icons;
        recursive = true;
      };
      # Wallpapers
      ".wallpapers/" = {
        source = ../../media/wallpaper;
        recursive = true;
      };
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = sysOptions.cursorSize;
    };
  };

  gtk = {
    enable = true;
    font.name = "Source Code Pro";
    theme = {
      name = "Catppuccin-GTK-Dark-Compact";
      package = pkgs.magnetic-catppuccin-gtk.override {
        shade = "dark";
        size = "compact";
      };
    };
  };
  xsession.enable = true;
  qt = {
    enable = true;

    # Catppuccin compat
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  programs.home-manager.enable = true;
}
