{ ... }:
let
  wallpaper = "normal";
  has_battery = true;
in { imports = [ (import ./shared { inherit wallpaper has_battery; }) ]; }
