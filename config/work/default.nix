{
  pkgs,
  pkgs-stable,
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

    (citrix_workspace.overrideAttrs (old: {
      meta = old.meta // {broken = false;};
      buildInputs = (old.buildInputs or []) ++ [ pkgs.webkitgtk_4_1 ];
      autoPatchelfIgnoreMissingDeps = (old.autoPatchelfIgnoreMissingDeps or []) ++ [
        "libwebkit2gtk-4.0.so.37"
        "libjavascriptcoregtk-4.0.so.18"
      ];
    }))

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
