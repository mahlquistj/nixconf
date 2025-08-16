{
  pkgs,
  config,
  sysOptions,
  ...
}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    game-devices-udev-rules
    gamescope
    gamemode
    mangohud
    wine
    clinfo
    lact
    winetricks
    cabextract
    lm_sensors
    protonup-qt
  ];

  users.users."${sysOptions.user}".extraGroups = ["adbusers"];
  programs.adb.enable = true;
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  programs.steam.enable = true;

  # Star Citizen compatability options
  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # AMD GPU
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
    graphics = {
      enable32Bit = true; # For 32 bit applications
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };

  services.blueman.enable = true;

  systemd = {
    packages = with pkgs; [lact];
    services.lactd.wantedBy = ["multi-user.target"];
    tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
