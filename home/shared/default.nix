{ pkgs, sysOptions, ... }:

{
  imports = [
    ./firefox.nix
    ./fish.nix
    ./ghostty.nix
    ./hyprland.nix
    ./spotify.nix
    ./starship.nix
    ./wofi.nix
    ./waybar.nix
  ];

  home = {
    username = "maj";
    homeDirectory = "/home/maj";
    stateVersion = "24.05";

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
    theme.name = "Catppuccin-Dark-BL-MB";
    theme.package = pkgs.magnetic-catppuccin-gtk;
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
