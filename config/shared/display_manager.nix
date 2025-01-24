{ pkgs, wallpapers, colors, ... }: {
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${wallpapers}/login-background.png";
        backgroundMode = "fill";

        passwordMask = true;
        passwordInputBackground = "${colors.background}";
        passwordInputRadius = 8;
        passwordInputVisibleCursor = true;

      };
    })
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "where-is-my-sddm";
    settings = { Theme = { Current = "where-is-my-sddm"; }; };
  };
}
