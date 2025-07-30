{pkgs, ...}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    blueman
  ];

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
    };
  };

  services = {
    hardware = {
      bolt.enable = true;
    };
    xserver.videoDrivers = ["amdgpu"];
  };

  programs.steam.enable = true;
}
