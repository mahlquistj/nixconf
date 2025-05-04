{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings.monitor = ["DP-1, 3440x1440@144, 0x0, 1"];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  home.packages = with pkgs; [
    cava
    prismlauncher
    (lutris.override {
      # Unused for now
      extraLibraries = pkgs: [
      ];
      # Unused for now
      extraPkgs = pkgs: [
      ];
    })
  ];
}
