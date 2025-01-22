{ inputs, pkgs, lib, config, ... }:
let colors = import ../colors.nix { };
in {
  imports = [ (import ./shared { inherit inputs pkgs lib config colors; }) ];
}
