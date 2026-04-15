{pkgs, ...}: {
  programs.xwayland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config = {
      niri = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["gnome"];
        "org.freedesktop.impl.portal.Screenshot" = ["gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
    };
  };
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
