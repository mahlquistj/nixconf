{ ... }:

{
  imports = [
    ./audio.nix
    ./display_manager.nix
    ./fonts.nix
    ./os.nix
    ./programs.nix
    ./shell.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/configuration.nix
  ];
}
