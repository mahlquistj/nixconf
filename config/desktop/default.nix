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
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  programs.steam.enable = true;

  # AMD GPU
  boot.initrd.kernelModules = ["amdgpu"];

  hardware = {
    opengl.extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];

    graphics.enable32Bit = true; # For 32 bit applications
    bluetooth.enable = true;
  };

  systemd = {
    packages = with pkgs; [lact];
    services.lactd.wantedBy = ["multi-user.target"];
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
