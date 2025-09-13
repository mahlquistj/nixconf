{
  pkgs,
  sysOptions,
  osConfig,
  ...
}: {
  imports = [
    ./btop.nix
    ./chrome.nix
    # ./fish.nix
    ./hyprland.nix
    ./kdeconnect.nix
    ./neovim.nix
    ./nushell.nix
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

  xdg.configFile = {
    "octotype/config.toml" = {
      force = true;
      text = ''
        [theme]
        spinner_color = "Yellow"
        spinner_symbol = "BrailleSix"

        [theme.text]
        success = "Green"
        warning = "Yellow"
        error = "Red"
        highlight = "Blue"

        [theme.plot]
        raw_wpm = "Gray"
        actual_wpm = "Yellow"
        accuracy = "Gray"
        errors = "Red"
        scatter_symbol = "Dot"
        line_symbol = "HalfBlock"

        [statistic]
        save_enabled = true
        history_limit = 10
      '';
    };
    "octotype/sources/gibberish.toml" = {
      force = true;
      text = ''
        [meta]
        name = "Quotes API"
        description = "Supplies random quotes"
        command = [
            "sh",
            "./gibberish.sh",
            "{word_count}",
            "{word_length}",
        ]
        output = "default"
        network_required = false
        required_tools = [
            "tr",
            "head",
            "fold",
        ]

        [parameters.word_count]
        min = 1
        max = 30
        step = 1
        default = 10

        [parameters.word_length]
        min = 2
        max = 15
        step = 1
        default = 5
      '';
    };
    "octotype/sources/pwd.toml" = {
      force = true;
      text = ''
        [meta]
        name = "PWD"
        description = "Supplies random quotes"
        command = [
            "pwd",
        ]
        output = "default"
        network_required = false
        required_tools = []

        [parameters.word_count]
        min = 1
        max = 30
        step = 1
        default = 10

        [parameters.word_length]
        min = 2
        max = 15
        step = 1
        default = 5
      '';
    };

    "octotype/sources/gibberish.sh" = {
      force = true;
      text = ''
        sleep 5 && tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c $(($1 * $2)) | fold -w $2
      '';
    };
    "octotype/modes/wordcount.toml" = {
      force = true;
      text = ''
        [meta]
        name = "WordCount"
        description = "Type an amount of correct words"

        [parameters.word_count]
        min = 10
        step = 10
        default = 60

        [conditions]
        allow_deletions = false

        [conditions.words_typed]
        String = "{word_count}"
      '';
    };
  };
}
