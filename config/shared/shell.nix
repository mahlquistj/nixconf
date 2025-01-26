{ pkgs, ... }:

{
  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
}
