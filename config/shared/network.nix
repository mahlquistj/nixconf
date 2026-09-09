{sysOptions, ...}: {
  # Enable networking
  networking = {
    hostName = sysOptions.name;
    networkmanager.enable = true;

    # GTA V battleye compat
    hosts = {
      "0.0.0.0" = [
        "paradise-s1.battleye.com"
        "test-s1.battleye.com"
        "paradiseenhanced-s1.battleye.com"
      ];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [42420 7777];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPorts = [42420 7777];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
