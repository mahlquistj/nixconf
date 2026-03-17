{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = ["DP-3, 3440x1440@144, 0x0, 1"];
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
