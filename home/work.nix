{ inputs, pkgs, lib, config, ... }:
let
  colors = import ../colors.nix { };
  wallpaper = "normal";
  has_battery = true;
in {
  imports = [
    (import ./shared {
      inherit inputs pkgs lib config colors wallpaper has_battery;
    })
  ];
}
