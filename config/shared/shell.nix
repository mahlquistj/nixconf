{pkgs, ...}: {
  environment.shells = with pkgs; [nushell];
  programs.fish.enable = true;
}
