{sysOptions, ...}: {
  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;
    systemd.enable = true;
    hyprland.enable = true;

    theme = "catppuccin_${sysOptions.theme}";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = ["dashboard" "workspaces"];
          middle = ["media"];
          right = ["volume" "systray" "notifications"];
        };
      };
    };

    settings = {
      bar = {
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
      };

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather.unit = "metric";
        };

        dashboard = {
          directories.enabled = true;
          stats.enable_gpu = true;
        };
      };

      theme = {
        bar.transparent = true;
        font = {
          name = "SauceCodePro Nerd Font Mono";
          size = "12px";
        };
      };
    };
  };
}
