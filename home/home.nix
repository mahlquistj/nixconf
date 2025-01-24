{ inputs, pkgs, lib, config, colors, ... }:
let
  wallpaper = "ultrawide";
  has_battery = false;
in { imports = [ (import ./shared { inherit wallpaper has_battery; }) ]; }
