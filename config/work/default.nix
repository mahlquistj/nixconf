{sysOptions, ...}: {
  imports = [../shared];

  hardware.bluetooth.enable = true;
}
