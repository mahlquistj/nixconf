{pkgs, ...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = {enable = true;};
  };
  environment.systemPackages = with pkgs; [
    pavucontrol # General Audio GUI
  ];
}
