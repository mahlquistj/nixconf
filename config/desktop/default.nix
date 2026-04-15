{
  pkgs,
  sysOptions,
  inputs,
  ...
}: {
  imports = [../shared];

  security.wrappers = {
    sniffnet = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_raw,cap_net_admin=eip";
      source = "${pkgs.sniffnet}/bin/sniffnet";
    };
  };

  environment.systemPackages = with pkgs; [
    alsa-scarlett-gui # Focusrite Scarlett GUI
    scarlett2 # Focusrite Scarlett firmware management
    sniffnet
    game-devices-udev-rules
    gamescope
    gamemode
    mangohud
    fluffychat
    element-desktop
    wine
    dotnet-runtime
    screen
    clinfo
    lact
    winetricks
    cabextract
    lm_sensors
    protonup-qt
    gpu-viewer
    vulkan-tools
    icu
    powershell
    inputs.hytale.packages.${system}.hytale-launcher
    android-tools
    sops
    age
    age-plugin-yubikey
    yubikey-manager
  ];

  users.groups.vintagestory = {};
  users.users.vintagestory = {
    group = "vintagestory";
    isSystemUser = true;
  };
  users.users."${sysOptions.user}".extraGroups = ["adbusers"];

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
      enable = true;
      enable32Bit = true; # For 32 bit applications
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        mesa
        vulkan-loader
        vulkan-validation-layers
        libvdpau-va-gl
        libva-vdpau-driver
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
