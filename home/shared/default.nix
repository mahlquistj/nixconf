{
  pkgs,
  sysOptions,
  osConfig,
  inputs,
  ...
}: {
  imports = [
    ./btop.nix
    ./chrome.nix
    ./discord.nix
    # ./fish.nix
    ./hyprland.nix
    ./kdeconnect.nix
    ./neovim.nix
    ./nix.nix
    ./nushell.nix
    ./obsidian.nix
    ./rio.nix
    ./rofi.nix
    ./spotify.nix
    ./starship.nix
    ./swaync.nix
    ./waybar.nix
    ./yazi.nix
  ];

  programs.direnv.enable = true;

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
      alacritty

      # Screen-shotting/recording
      hyprshot
      wf-recorder
      slurp

      # Usb mounting
      udiskie

      # Other
      inputs.octotype.packages."${sysOptions.system}".default
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

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-termfilechooser
      ];
    };
    configFile = {
      "octotype/config.toml" = {
        force = true;
        text = ''
          [theme]
          spinner_color = "#f9e2af"
          spinner_symbol = "BrailleSix"

          [theme.text]
          success = "#a6e3a1"
          warning = "#f9e2af"
          error = "#f38ba8"
          highlight = "#89b4fa"

          [theme.plot]
          raw_wpm = "#cdd6f4"
          actual_wpm = "#f9e2af"
          accuracy = "#cdd6f4"
          errors = "#f38ba8"
          scatter_symbol = "Dot"
          line_symbol = "Braille"

          [statistic]
          save_enabled = true
          history_limit = 10
        '';
      };
      "octotype/sources/gibberish.toml" = {
        force = true;
        text = ''
          [meta]
          name = "Gibberish"
          description = "Supplies random characters"
          command = [
              "sh",
              "./gibberish.sh",
              "{total words}",
              "{word length}",
          ]
          output = "default"
          network_required = false
          required_tools = [
              "tr",
              "head",
              "fold",
          ]

          [parameters."total words"]
          min = 1
          max = 30
          step = 1
          default = 10

          [parameters."word length"]
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
      "octotype/sources/brownfox.toml" = {
        force = true;
        text = ''
          [meta]
          name = "BrownFox"
          description = "The quick brown fox"
          command = [
            "sh",
            "./brownfox.sh"
          ]
          required_tools = ["echo"]
        '';
      };
      "octotype/sources/brownfox.sh" = {
        force = true;
        text = ''
          sleep 2 && echo "The quick brown fox jumps over the lazy dog, testing my typing speed with every leap, but I'll soon catch up."
        '';
      };
      "octotype/modes/default.toml" = {
        force = true;
        text = ''
          [meta]
          name = "Default"
          description = "The default typing trainer experience"
        '';
      };
      "octotype/modes/perfectionism.toml" = {
        force = true;
        text = ''
          [meta]
          name = "Perfectionism"
          description = "Don't make any mistakes!"

          [conditions]
          allow_errors = false
        '';
      };
      "octotype/modes/wordcount.toml" = {
        force = true;
        text = ''
          [meta]
          name = "WordCount"
          description = "Type an amount of correct words"

          [parameters."words to type"]
          min = 10
          step = 10
          default = 60

          [conditions]
          words_typed = "{words to type}"
        '';
      };
    };
  };
}
