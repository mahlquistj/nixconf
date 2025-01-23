{ ... }:

{
  imports = [ ../shared ./hardware-configuration.nix ];

  # Disk encryption
  boot.initrd.luks.devices."luks-058dec93-cc6c-4357-9bbf-e1843b3dafe4".device =
    "/dev/disk/by-uuid/058dec93-cc6c-4357-9bbf-e1843b3dafe4";
}
