{
  pkgs,
  pkgs-stable,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];

  # LACT daemon
  services.lact.enable = true;

  hardware = {
    amdgpu = {
      opencl.enable = true;
      overdrive.enable = true;
    };
    graphics = {
      enable = true;
      package = pkgs-stable.mesa;
      package32 = pkgs-stable.pkgsi686Linux.mesa;
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        vulkan-loader
        vulkan-validation-layers
        libvdpau-va-gl
        libva-vdpau-driver
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    lact
    clinfo
    rocmPackages.rocminfo
  ];

  # Handle programs that hardcode the old FHS path to ROCm
  systemd = {
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
