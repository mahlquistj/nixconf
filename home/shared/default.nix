{
  pkgs,
  sysOptions,
  osConfig,
  ...
}: {
  imports = [
    ./btop.nix
    ./chrome.nix
    ./fish.nix
    ./hyprland.nix
    ./kdeconnect.nix
    ./neovim.nix
    ./nix.nix
    ./rio.nix
    ./rofi.nix
    ./spotify.nix
    ./starship.nix
    ./swaync.nix
    ./waybar.nix
    ./yazi.nix
  ];

  catppuccin.mako.enable = false;

  home = {
    inherit (osConfig.system) stateVersion;

    username = sysOptions.user;
    homeDirectory = "/home/${sysOptions.user}";

    packages = with pkgs; [
      # Utils
      jq # CLI JSON parsing
      eza # `ls` substitute
      playerctl
      ethtool
      dig
      libnotify

      # Screen-shotting/recording
      hyprshot
      wf-recorder
      slurp

      # Social
      vesktop

      # Usb mounting
      udiskie
    ];

    # Files
    file = {
      # Cursors
      ".icons/" = {
        source = ../../media/.icons;
        recursive = true;
      };
      # Wallpapers
      ".wallpapers/" = {
        source = ../../media/wallpaper;
        recursive = true;
      };
    };

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = sysOptions.cursorSize;
    };

    sessionVariables = {
      PROTON_LOG = "1";
      PROTON_LOG_DIR = "/home/maj/";

      NIXOS_OZONE_WL = "1";

      MOZ_ENABLE_WAYLAND = "1";

      GTK_CSD = "0";
      GTK_USE_PORTAL = "1";

      NIXOS_XDG_OPEN_USE_PORTAL = "1";

      DISCORD_SKIP_HOST_GPU_BLOCKLIST = "1";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };

  gtk = {
    enable = true;
    font.name = "Source Code Pro";
    theme = {
      name = "Catppuccin-GTK-Dark-Compact";
      package = pkgs.magnetic-catppuccin-gtk.override {
        shade = "dark";
        size = "compact";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
    };
  };
  qt = {
    enable = true;

    # Catppuccin compat
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  programs.home-manager.enable = true;
}
