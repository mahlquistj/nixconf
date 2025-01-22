{ pkgs, ... }:

{
  home = {
    username = "namish";
    homeDirectory = "/home/namish";
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
  };

  programs.home-manager.enable = true;
}
