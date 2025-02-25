{pkgs, ...}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    blueman
  ];

  hardware.bluetooth.enable = true;
}
