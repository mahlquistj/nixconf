{pkgs, ...}: {
  imports = [../shared];
  services.blueman.enable = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["uinput"];
    kernelPatches = [
      {
        # Make my unofficial receiver work for my GH guitar
        name = "xpad-unofficial-wireless-receiver-presence";
        patch = ../shared/patches/xpad-unofficial-receiver.patch;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    clonehero
  ];
}
