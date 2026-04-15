{
  pkgs,
  sysOptions,
  wallpapers,
  ...
}: {
  services.swww.enable = true;
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  programs.niri = {
    settings = {
      prefer-no-csd = true;

      spawn-at-startup = [
        {command = ["swaync"];}
        {command = ["udiskie"];}
      ];

      input = {
        focus-follows-mouse.enable = true;

        keyboard = {
          xkb.layout = "us";
        };
      };

      layout = {
        gaps = 6;

        focus-ring = {
          enable = true;
          width = 2;
        };

        tab-indicator = {
          hide-when-single-tab = true;
        };
      };

      window-rules = [
        {
          opacity = 0.98;
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
          draw-border-with-background = false;
        }
      ];

      binds = {
        #------- Spawners -------#
        "Mod+Return".action.spawn = "rio";
        "Mod+Space".action.spawn = ["rofi" "-show" "drun"];
        "Mod+N".action.spawn = ["swaync-client" "-t"];

        #------- Actions -------#
        "Mod+Q".action.close-window = {};
        "Print".action.screenshot = {};
        "Alt+Print".action.screenshot-window = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Mod+Shift+E".action.quit = {};
        "Ctrl+Alt+Delete".action.quit = {};

        # System volume up/down
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "-l" "1.25" "@DEFAULT_AUDIO_SINK@" "5%+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "-l" "1.25" "@DEFAULT_AUDIO_SINK@" "5%-"];

        # Media player
        "Ctrl+XF86AudioRaiseVolume".action.spawn = ["playerctl" "volume" "0.1+"];
        "Ctrl+XF86AudioLowerVolume".action.spawn = ["playerctl" "volume" "0.1-"];
        "XF86AudioNext".action.spawn = ["playerctl" "next"];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];

        # Mute/Unmute
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mut" "@DEFAULT_AUDIO_SOURCE@" "toggle"];

        # Brightness up/down
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "10%+"];
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];

        #------- Navigation -------#
        # Windows
        "Mod+H".action.focus-column-left = {};
        "Mod+Left".action.focus-column-left = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+Up".action.focus-window-up = {};

        # Workspaces
        "Mod+U".action.focus-workspace-down = {};
        "Mod+Page_Down".action.focus-workspace-down = {};
        "Mod+I".action.focus-workspace-up = {};
        "Mod+Page_Up".action.focus-workspace-up = {};

        # Monitors
        "Mod+Shift+H".action.focus-monitor-left = {};
        "Mod+Shift+Left".action.focus-monitor-left = {};
        "Mod+Shift+L".action.focus-monitor-right = {};
        "Mod+Shift+Right".action.focus-monitor-right = {};
        "Mod+Shift+J".action.focus-monitor-down = {};
        "Mod+Shift+Down".action.focus-monitor-down = {};
        "Mod+Shift+K".action.focus-monitor-up = {};
        "Mod+Shift+Up".action.focus-monitor-up = {};

        #------- Movement -------#
        # Window within workspace
        "Mod+Ctrl+H".action.move-column-left = {};
        "Mod+Ctrl+Left".action.move-column-left = {};
        "Mod+Ctrl+L".action.move-column-right = {};
        "Mod+Ctrl+Right".action.move-column-right = {};
        "Mod+Ctrl+J".action.move-window-down = {};
        "Mod+Ctrl+Down".action.move-window-down = {};
        "Mod+Ctrl+K".action.move-window-up = {};
        "Mod+Ctrl+Up".action.move-window-up = {};

        # Window to monitor
        "Mod+Ctrl+Shift+H".action.move-column-to-monitor-left = {};
        "Mod+Ctrl+Shift+Left".action.move-column-to-monitor-left = {};
        "Mod+Ctrl+Shift+L".action.move-column-to-monitor-right = {};
        "Mod+Ctrl+Shift+Right".action.move-column-to-monitor-right = {};
        "Mod+Ctrl+Shift+J".action.move-column-to-monitor-down = {};
        "Mod+Ctrl+Shift+Down".action.move-column-to-monitor-down = {};
        "Mod+Ctrl+Shift+K".action.move-column-to-monitor-up = {};
        "Mod+Ctrl+Shift+Up".action.move-column-to-monitor-up = {};

        # Window to workspace
        "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+I".action.move-column-to-workspace-up = {};
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};

        # Workspace ordering
        "Mod+Shift+U".action.move-workspace-down = {};
        "Mod+Shift+Page_Down".action.move-workspace-down = {};
        "Mod+Shift+I".action.move-workspace-up = {};
        "Mod+Shift+Page_Up".action.move-workspace-up = {};

        #------- Layouting -------#
        # Window into column
        "Mod+comma".action.consume-window-into-column = {};
        "Mod+period".action.expel-window-from-column = {};
        "Mod+bracketleft".action.consume-or-expel-window-left = {};
        "Mod+bracketright".action.consume-or-expel-window-right = {};

        # Resizing
        "Mod+R".action.switch-preset-column-width = {};
        "Mod+Shift+R".action.switch-preset-window-height = {};
        "Mod+F".action.maximize-column = {};
        "Mod+C".action.center-column = {};
        "Mod+minus".action.set-column-width = "-10%";
        "Mod+equal".action.set-column-width = "+10%";
        "Mod+Shift+minus".action.set-window-height = "-10%";
        "Mod+Shift+equal".action.set-window-height = "+10%";
        "Mod+Ctrl+R".action.reset-window-height = {};
        "Mod+Shift+F".action.fullscreen-window = {};

        # Floating
        "Mod+V".action.toggle-window-floating = {};
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};
      };
    };
  };
}
