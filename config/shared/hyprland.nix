{pkgs, ...}: {
  # Hyprland service needed directly in the config
  # for the home-manager module to work
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };

  # Enable portals for Wayland screen sharing and file chooser integration.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = ["gtk" "hyprland"];
      };
      hyprland = {
        default = ["gtk" "hyprland"];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
