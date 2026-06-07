{pkgs, ...}: let
  patchedNiri = pkgs.niri.overrideAttrs (prevAttrs: {
    patches =
      (prevAttrs.patches or [])
      ++ [
        # FUTURE(Sirius902) Add SHM screencast fallback so Discord/Electron
        # consumers that don't accept dmabuf modifiers can negotiate a format.
        # https://github.com/niri-wm/niri/pull/1791 (fixes #455)
        (pkgs.fetchpatch2 {
          name = "niri-pr-1791-shm-sharing.patch";
          url = "https://github.com/niri-wm/niri/compare/dd1c3bcb9f1ef416df33ffa22d1d9bcee1398e7d...6c1613cee488515f3021ae9d8ef9233d6719c13f.patch?full_index=1";
          hash = "sha256-Ipw5BbDfNPQOGOzCH979axJosC01bfTgz/Hi1iBgC84=";
        })
      ];
  });
in {
  programs.xwayland.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    config = {
      niri = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
        "org.freedesktop.impl.portal.RemoteDesktop" = ["gnome"];
        "org.freedesktop.impl.portal.Screenshot" = ["gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
        "org.freedesktop.impl.portal.Access" = ["gtk"];
        "org.freedesktop.impl.portal.Notification" = ["gtk"];
      };
    };
  };
  programs.niri = {
    enable = true;
    package = patchedNiri;
  };
}
