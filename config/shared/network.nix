{sysOptions, ...}: {
  # Enable networking
  networking = {
    hostName = sysOptions.name;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPorts = [];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
