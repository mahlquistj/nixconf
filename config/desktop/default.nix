{
  pkgs,
  config,
  ...
}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    gamescope
    clinfo
    lact
  ];
  programs.steam.enable = true;

  # AMD GPU
  boot.initrd.kernelModules = ["amdgpu"];

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable32Bit = true; # For 32 bit applications
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  systemd = {
    packages = with pkgs; [lact];
    services.lactd.wantedBy = ["multi-user.target"];
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
