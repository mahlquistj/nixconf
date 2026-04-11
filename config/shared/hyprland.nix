{pkgs, ...}: {
  # Hyprland service needed directly in the config
  # for the home-manager module to work
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # Enable portals for Wayland screen sharing and file chooser integration.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    config = {
      common = {
        default = ["gtk"];
      };
      Hyprland = {
        default = ["hyprland" "gtk"];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
