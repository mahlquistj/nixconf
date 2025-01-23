{ pkgs, ... }:

{
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
    ];

    sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };

    # Files
    file = {
      # Cursors
      ".icons/" = {
        source = ../../media/cursor;
        recursive = true;
      };
      # Wallpapers
      ".wallpapers/" = {
        source = ../../media/wallpaper;
        recursive = true;
      };
    };
  };

  programs.home-manager.enable = true;
}
