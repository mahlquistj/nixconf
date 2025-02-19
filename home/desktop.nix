{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings.monitor = ["DP-1, 3440x1440@144, 0x0, 1"];
    extraConfig = ''
      env = LIBVA_DRIVER_NAME,nvidia
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = NVD_BACKEND,direct
    '';
  };

  home.packages = with pkgs; [
    cava
  ];
}
