{ pkgs, lib, config, ... }:

{
  imports = [ ./audio.nix ./fonts.nix ./os.nix ./programs.nix ./shell.nix ];
}
