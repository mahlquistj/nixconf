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

      escape_key_behviour = "close_window";
      pop_on_backspace = true;
      close_on_focs_loss = true;
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
        light = {
          name = "catpuccin-mocha";
          icon_theme = "auto";
        };
        dark = {
          name = "catpuccin-mocha";
          icon_theme = "auto";
        };
      };

      launcher_window = {
        opacity = 0.98;
        blur.enabled = true;

        compact_mode.enabled = true;

        layer_shell = {
          enabled = true;
          keyboard_interactivity = "on_demand";
          layer = "overlay";
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
    ];
  };
}
