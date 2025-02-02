{ pkgs, sysOptions, wallpapers, ... }: {
  # Disable catppuccin for SDDM
  catppuccin.sddm.enable = false;

  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${wallpapers}/login-${sysOptions.wallpaper}.jpg";
        backgroundMode = "fill";

        passwordMask = true;
        passwordInputBackground = "rgba(0, 0, 0, 0.8)";
        passwordInputRadius = 15;
        passwordInputVisibleCursor = false;
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
