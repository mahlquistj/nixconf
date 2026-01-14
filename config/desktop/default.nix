{
  pkgs,
  sysOptions,
  inputs,
  ...
}: {
  imports = [../shared];

  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui # Focusrite Scarlett GUI
    scarlett2 # Focusrite Scarlett firmware management
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
    gpu-viewer
    vulkan-tools
    icu
    inputs.hytale.packages.${system}.hytale-launcher
    android-tools
  ];

  users.users."${sysOptions.user}".extraGroups = ["adbusers"];
  services.udev.packages = with pkgs; [
    android-udev-rules
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    icu
    libglvnd
    mesa
    # common runtime deps for games:
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
    wayland
    libxkbcommon
    vulkan-loader
    alsa-lib
    zlib
    openssl
    stdenv.cc.cc.lib
  ];

  programs.steam.enable = true;

  services.wivrn = {
    enable = true;
    openFirewall = true;
    defaultRuntime = true;

    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
    config = {
      enable = true;
      json = {
        # 1.0x foveation scaling
        scale = 1.0;
        # 100 Mb/s
        bitrate = 100000000;
        encoders = [
          {
            encoder = "vaapi";
            codec = "h265";
            width = 1.0;
            height = 1.0;
            offset_x = 0.0;
            offset_y = 0.0;
          }
        ];
      };
    };
  };

  # OBS
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
  };

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
        mesa
        vulkan-loader
        vulkan-validation-layers
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
