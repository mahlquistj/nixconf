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
    amazon-ecr-credential-helper
    postgresql
    (python3.withPackages (python-pkgs:
      with python-pkgs; [
        netaddr
        paramiko
        pytz
        psycopg2
      ]))
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

  networking = {
    wireguard.enable = true;
    wg-quick = {
      interfaces = {
        wg0-backup = {
          configFile = "/home/${sysOptions.user}/wireguard/wg0-backup.conf";
          autostart = false;
        };
      };
    };
  };
}
