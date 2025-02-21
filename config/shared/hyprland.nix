{pkgs, ...}: {
  # Hyprland service needed directly in the config
  # for the home-manager module to work
  programs = {
    hyprland = {
      enable = true;
      # xwayland.enable = true;
    };
  };
}
