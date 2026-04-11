{
  pkgs,
  inputs,
  ...
}: {
  # wayland.windowManager.hyprland = {
  #   settings = {
  #     monitor = [
  #       "DP-3, 3440x1440@144, 0x0, 1"
  #       "DP-4, 2560x720@60, 440x1440, 1"
  #     ];
  #   };
  # };

  programs.niri.settings.outputs = {
    "DP-3" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 144.001;
      };
      scale = 1;
      position = {
        x = 0;
        y = 0;
      };
    };
    "DP-4" = {
      mode = {
        width = 2560;
        height = 720;
        refresh = 60.266;
      };
      scale = 1;
      position = {
        x = 440;
        y = 1440;
      };
    };
  };

  programs.fancontrol-gui.enable = true;

  home.packages = with pkgs; [
    prismlauncher
    vintagestory
    rare
    (pkgs.discord.override {
      withVencord = true;
    })
    vencord
    mixxx
    inputs.nix-citizen.packages.${system}.rsi-launcher
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
