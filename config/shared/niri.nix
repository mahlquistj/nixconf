{pkgs, ...}: {
  programs.xwayland.enable = true;
  xdg.portal.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
}
