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

      # Hyprcursor theme
      HYPRCURSOR_THEME = "phinger-cursors-light";
      HYPRCURSOR_SIZE = "24";
    };

    # Cursor icons
    file.".icons/" = {
      source = "../../media/cursor/";
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
