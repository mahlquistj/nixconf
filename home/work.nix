{ inputs, pkgs, lib, config, ... }:
let
  colors = import ../colors.nix { };
  wallpaper = "normal";
in {
  imports =
    [ (import ./shared { inherit inputs pkgs lib config colors wallpaper; }) ];
}
