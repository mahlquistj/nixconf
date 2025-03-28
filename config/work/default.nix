{pkgs, ...}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    blueman
  ];

  hardware = {
    bluetooth.enable = true;
  };

  services.hardware = {
    bolt.enable = true;
  };

  programs.steam.enable = true;
}
