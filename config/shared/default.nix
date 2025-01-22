{ pkgs, lib, config, ... }:

{
  imports = [
    ./audio.nix
    ./default.nix
    ./fonts.nix
    ./os.nix
    ./programs.nix
    ./shell.nix
  ];
}
