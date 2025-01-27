{ pkgs, sysOptions, wallpapers, style, ... }: {
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${wallpapers}/login-background.png";
        backgroundMode = "fill";

        passwordMask = true;
        passwordInputBackground = "#${style.background}60";
        passwordInputRadius = 8;
        passwordInputVisibleCursor = true;
      };
    })
  ];

  environment.variables.QT_QPA_PLATFORM = "wayland";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "where_is_my_sddm_theme";
    settings = {
      Theme = {
        CursorTheme = "phinger-cursors-light";
        CursorSize = sysOptions.cursorSize;
      };
    };
  };
}
