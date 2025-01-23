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

    # Hint electron apps to use wayland
    sessionVariables.NIXOS_OZONE_WL = "1";

    # Cursor icons
    pointerCursor = {
      hyprcursor.enable = true;
      name = "phinger-cursors-light";
    };
    file.".icons/" = {
      source = "../../media/cursor/";
      recursive = true;
    };
  };

  programs.home-manager.enable = true;
}
