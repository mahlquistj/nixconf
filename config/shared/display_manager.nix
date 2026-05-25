{pkgs, wallpapers, sysOptions, ...}: {
  environment.variables.QT_QPA_PLATFORM = "wayland";

  services.xserver.enable = true;

  services.accounts-daemon.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    settings = {
      Theme = {
        CursorTheme = "phinger-cursors-light";
        CursorSize = sysOptions.cursorSize;
      };
      Users = {
        RememberLastUser = true;
      };
    };
  };

  catppuccin.sddm = {
    enable = true;
    background = "${wallpapers}/${sysOptions.wallpaper}-login.png";
    loginBackground = true;
    clockEnabled = true;
    userIcon = true;
  };

  # Make the face icon accessible to SDDM
  systemd.tmpfiles.rules = [
    "C+ /var/lib/AccountsService/icons/${sysOptions.user} - - - - ${../../media/.face.icon}"
  ];

  # Tell AccountsService to use the icon and show the user
  environment.etc."AccountsService/users/${sysOptions.user}".text = ''
    [User]
    Icon=/var/lib/AccountsService/icons/${sysOptions.user}
    SystemAccount=false
  '';
}
