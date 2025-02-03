{ pkgs, ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = { enable = true; };

  };
  environment.systemPackages = [
    pkgs.pwvucontrol # Audio GUI
  ];
}
