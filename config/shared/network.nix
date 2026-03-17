{sysOptions, ...}: {
  # Enable networking
  networking = {
    hostName = sysOptions.name;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [42420];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPorts = [42420];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
