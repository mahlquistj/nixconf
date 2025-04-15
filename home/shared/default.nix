{
  pkgs,
  sysOptions,
  osConfig,
  ...
}: {
  imports = [
    ./btop.nix
    ./firefox.nix
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
  ];

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

      # Management
      nemo # File manager

      # Screenshotting
      hyprshot

      # Social
      discord

      # Chromium for my moonlander
      chromium
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
      NIXOS_OZONE_WL = "1";

      MOZ_ENABLE_WAYLAND = "1";

      GTK_CSD = "0";
      GTK_USE_PORTAL = "1";

      NIXOS_XDG_OPEN_USE_PORTAL = "1";
    };
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
      name = "Papirus";
    };
  };
  xsession.enable = true;
  qt = {
    enable = true;

    # Catppuccin compat
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };

  programs.home-manager.enable = true;
}
