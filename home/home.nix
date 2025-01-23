{ inputs, pkgs, lib, config, ... }:
let
  colors = import ../colors.nix { };
  wallpaper = "ultrawide";
  has_battery = false;
in {
  imports = [
    (import ./shared {
      inherit inputs pkgs lib config colors wallpaper has_battery;
    })
  ];
}
