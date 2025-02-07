{ pkgs, ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = { enable = true; };

  };
  environment.systemPackages = [
    pkgs.pavucontrol # Audio GUI
  ];
}
