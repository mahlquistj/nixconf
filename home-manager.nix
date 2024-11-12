{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ];

  home-manager.users.maj = {
    home.packages = with pkgs; [ btop ];
    programs.bash.enable = true;

    home.stateVersion = "24.05";
  };

  home-manager.useGlobalPkgs = true;
}
