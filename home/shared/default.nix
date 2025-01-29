{ pkgs, sysOptions, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fish.nix
    ./ghostty.nix
    ./hyprland.nix
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

  gtk.enable = true;
  xsession.enable = true;
  qt.enable = true;

  programs.home-manager.enable = true;
}
