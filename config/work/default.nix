{
  pkgs,
  sysOptions,
  ...
}: {
  imports = [../shared];

  # Docker daemon setup
  virtualisation.docker = {
    enable = true;
  };
  users.users."${sysOptions.user}".extraGroups = ["docker"];

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
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  programs.steam.enable = true;
}
