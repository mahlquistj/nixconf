{
  pkgs,
  sysOptions,
  inputs,
  ...
}: {
  imports = [../shared "gpu.nix"];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # Star Citizen compatability options
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };
  };

  hardware = {
    steam-hardware.enable = true;
    bluetooth.enable = true;
  };

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
    winetricks
    cabextract
    lm_sensors
    protonup-qt
    gpu-viewer
    vulkan-tools
    icu
    powershell
    inputs.hytale.packages.${sysOptions.system}.hytale-launcher
    android-tools
    sops
    age
    age-plugin-yubikey
    yubikey-manager
  ];

  users = {
    groups.vintagestory = {};
    users = {
      vintagestory = {
        group = "vintagestory";
        isSystemUser = true;
      };

      "${sysOptions.user}".extraGroups = ["adbusers" "audio"];
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        libglvnd
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
    };

    steam.enable = true;

    # OBS
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
  };

  services = {
    wivrn = {
      enable = true;
      openFirewall = true;

      # Run WiVRn as a systemd service on startup
      autoStart = false;

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

    blueman.enable = true;

    udev.extraRules = ''
      # Disable Sony DualSense (PS5) Touchpad acting as a mouse over USB
      ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1", ENV{ID_INPUT_TOUCHPAD}="", ENV{ID_INPUT_MOUSE}=""
    '';
  };
}
