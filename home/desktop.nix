{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.monitor = ["DP-1, 3440x1440@144, 0x0, 1"];
  home.packages = with pkgs; [
    ethtool
  ];
}
