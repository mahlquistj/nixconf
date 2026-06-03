{
  pkgs,
  inputs,
  ...
}: {
  catppuccin.vicinae.enable = true;
  services.vicinae = {
    enable = true;
    systemd = {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };

    settings = {
      telemetry.system_info = false;

      escape_key_behaviour = "close_window";
      pop_on_backspace = true;
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = false;
      favicon_service = "twenty";

      font = {
        normal = {
          size = 12;
          family = "Sauce Code Pro";
        };
      };

      theme = {
        dark = {
          name = "catppuccin-mocha";
          icon_theme = "auto";
        };
      };

      launcher_window = {
        opacity = 0.80;

        compact_mode.enabled = true;

        # client_side_decorations = {
        # enabled = false;
        # };

        layer_shell = {
          enabled = true;
          keyboard_interactivity = "on_demand";
          layer = "top";
        };
      };

      pixmap_cache_mb = 100;

      keybinds = {
        open-search-filter = "control+F";
      };

      favorites = [
        "clipboard:history"
      ];
    };

    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
      nix
      wifi-commander
      niri
      github
      protondb-search
    ];
  };
}
