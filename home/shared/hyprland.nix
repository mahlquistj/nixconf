{
  pkgs,
  inputs,
  sysOptions,
  wallpapers,
  ...
}: {
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 300; # 5 min
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 600; # 10 min
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 630; # 10 min, 30 sec
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 1800; # 30 min
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
    hyprpaper = {
      enable = true;
      settings = {
        preload = ["${wallpapers}/${sysOptions.wallpaper}.png"];
        wallpaper = [", ${wallpapers}/${sysOptions.wallpaper}.png"];
      };
    };
  };
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${sysOptions.system}.default;
    settings = {
      # Inspiration1: https://github.com/justinmdickey/publicdots/blob/main/.config/hypr/hyprlock.conf
      # Inspiration2: https://github.com/Daholli/nixos-config/blob/main/modules/nixos/desktop/addons/hyprlock/default.nix

      # ACTUAL SETTINGS
      general = {
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = false;
        grace = 0;
        ignore_empty_input = true;
        disable_loading_bar = true;
      };

      # WIDGETS
      background = {
        path = "screenshot";
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = null;

    plugins = [];

    settings = {
      # Important keys
      "$mod" = "SUPER";
      "$modshift" = "SUPER SHIFT";
      "$modalt" = "SUPER ALT";
      "$modctl" = "SUPER CTRL";
      "$modhyper" = "SUPER CTRL ALT SHIFT";
      "$modmeh" = "CTRL ALT SHIFT";

      # App
      "$terminal" = "rio";
      "$menu" = "rofi -show drun";
      "$browser" = "chromium";
      "$lock" = "hyprlock";

      # Startup
      exec-once = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP "
        "dbus-update-activation-environment --systemd --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP"
        "swaync"
        "udiskie"
      ];

      # Window rules
      windowrulev2 = [
        # Stop hyprland from stealing mouse in bitwig studio
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

        # Spotify blur
        "opacity 0.90, class:(Spotify|spotify)"
      ];

      # Setttings and styling
      general = {
        gaps_in = 2;
        gaps_out = 5;

        border_size = 1;

        resize_on_border = true;

        # col.* has to be in quotes
        "col.active_border" = "$peach";
        "col.inactive_border" = "$base";
      };
      cursor = {
        inactive_timeout = 10;
        hide_on_key_press = true;
      };
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      decoration = {
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          new_optimizations = true;
          xray = true;
          ignore_opacity = true;
        };

        rounding = 10;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.1;
      };
      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        focus_on_activate = true;
      };
      master = {
        orientation = "center";
        slave_count_for_center_master = 0;
        # use half of the scrren width available
        mfact = "0.5";
      };

      workspace = [
        "special:scratchpad, on-created-empty:rio"
      ];

      # Bindings
      bindm = ["$mod, mouse:272, movewindow"];
      binde = [
        # Resizing
        ## Arrow keys
        "$modctl, left, resizeactive, -10% 0"
        "$modctl, right, resizeactive, 10% 0"
        "$modctl, up, resizeactive, 0 -10%"
        "$modctl, down, resizeactive, 0 10%"
        ## Vim keys
        "$modctl, H, resizeactive, -10% 0"
        "$modctl, L, resizeactive, 10% 0"
        "$modctl, K, resizeactive, 0 -10%"
        "$modctl, J, resizeactive, 0 10%"

        # System volume up/down
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.25 @DEFAULT_AUDIO_SINK@ 5%-"

        # Media player volume up/down
        "CTRL,XF86AudioRaiseVolume, exec, playerctl volume 0.1+"
        "CTRL,XF86AudioLowerVolume, exec, playerctl volume 0.1-"

        # Brightness up/down
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];
      bind =
        [
          # Spawners
          "$mod, Return, exec, $terminal"
          "$mod, SPACE, exec, $menu"
          "$mod, ESCAPE, exec, $lock"
          "$modshift, E, exit"
          "$mod, N, exec, swaync-client -t"

          # Layout toggle
          ''
            $mod, T, exec, hyprctl keyword general:layout "$(hyprctl getoption general:layout | grep -q 'dwindle' && echo 'master' || echo 'dwindle')"
          ''

          # Special workspace toggle
          "$modhyper, Return, togglespecialworkspace, scratchpad"
          "$modmeh, Return, movetoworkspace, scratchpad"

          # Master layout
          "$mod, M, layoutmsg, focusmaster"
          "$modctl, M, layoutmsg, swapwithmaster"
          "$modhyper, H, layoutmsg, orientationleft"
          "$modhyper, L, layoutmsg, orientationright"
          "$modhyper, K, layoutmsg, orientationcenter"
          "$modhyper, up, layoutmsg, orientationnext"
          "$modhyper, down, layoutmsg, orientationprev"

          # Moving focus
          ## Arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          ## Vim keys
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Window control
          "$mod, V, togglefloating"
          "$mod, J, togglesplit"
          "$mod, F, fullscreen"
          "$mod, Q, killactive"

          # Move window
          ## Arrow keys
          "$modshift, left, movewindow, l"
          "$modshift, right, movewindow, r"
          "$modshift, up, movewindow, u"
          "$modshift, down, movewindow, d"
          ## Vim keys
          "$modshift, H, movewindow, l"
          "$modshift, L, movewindow, r"
          "$modshift, K, movewindow, u"
          "$modshift, J, movewindow, d"

          # Move workspaces
          ## Arrow keys
          "$modalt, left, movecurrentworkspacetomonitor, l"
          "$modalt, right, movecurrentworkspacetomonitor, r"
          "$modalt, up, movecurrentworkspacetomonitor, u"
          "$modalt, down, movecurrentworkspacetomonitor, d"
          ## Vim Keys
          "$modalt, H, movecurrentworkspacetomonitor, l"
          "$modalt, L, movecurrentworkspacetomonitor, r"
          "$modalt, K, movecurrentworkspacetomonitor, u"
          "$modalt, J, movecurrentworkspacetomonitor, d"

          # Screenshotting
          "$mod, PRINT, exec, hyprshot -m window"
          ", PRINT, exec, hyprshot -m output"
          "$modshift, PRINT, exec, hyprshot -m region"

          # Video recording
          "$mod, R, exec, ~/.config/hypr/scripts/screen-record.sh area"
          "$modshift, R, exec, ~/.config/hypr/scripts/screen-record.sh screen"
          "$mod, S, exec, pkill -INT wf-recorder && notify-send 'Screen Recording' 'Recording stopped.'"

          # Audio
          ## Volume mute
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ## Microphone mute
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Media player
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86AudioPlay, exec, playerctl play-pause"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${
                toString ws
              }" # Switch workspace
              "$modshift, code:1${toString i}, movetoworkspace, ${
                toString ws
              }" # Move window to workspace
            ])
            9)
        );
    };

    extraConfig = ''
      env = PATH,/home/${sysOptions.user}/.nix-profile/bin:/run/current-system/sw/bin:$PATH

      env = HYPRCURSOR_THEME,phinger-cursors-light
      env = HYPRCURSOR_SIZE,${builtins.toString sysOptions.cursorSize}
      env = XCURSOR_SIZE,${builtins.toString sysOptions.cursorSize}

      env = HYPRSHOT_DIR,screenshots

    '';
  };

  home.file.".config/hypr/scripts/screen-record.sh" = {
    executable = true; # Make the script runnable
    text = ''
      #!/usr/bin/env bash

      # Directory to save recordings
      REC_DIR="$HOME/Videos/Screen-Recordings"
      mkdir -p "$REC_DIR"

      # Filename with timestamp
      FILENAME="$REC_DIR/rec_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

      # Check if a recording is already in progress
      if pgrep -x "wf-recorder" > /dev/null; then
          notify-send "Recording in Progress" "A screen recording is already active."
          exit 1
      fi

      # Main logic based on argument
      case $1 in
          area)
              # Select an area and record
              GEOMETRY=$(slurp)
              if [ -n "$GEOMETRY" ]; then
                  notify-send "Screen Recording" "Starting area recording..."
                  wf-recorder -g "$GEOMETRY" -f "$FILENAME"
              else
                  notify-send "Screen Recording" "Selection cancelled."
              fi
              ;;
          screen)
              # Record the entire screen
              notify-send "Screen Recording" "Starting full-screen recording..."
              wf-recorder -f "$FILENAME"
              ;;
          *)
              echo "Usage: $0 {area|screen}"
              exit 1
              ;;
      esac
    '';
  };
}
