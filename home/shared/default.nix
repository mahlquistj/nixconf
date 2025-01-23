{ inputs, pkgs, lib, config, colors, ... }:

{
  imports = [
    (import ./alacritty.nix { inherit inputs pkgs lib config colors; })
    #(import ./fish.nix { inherit inputs pkgs lib config colors; })
    (import ./general.nix { inherit inputs pkgs lib config colors; })
    (import ./hyprland.nix { inherit inputs pkgs lib config colors; })
    (import ./wofi.nix { inherit inputs pkgs lib config colors; })
  ];
}
