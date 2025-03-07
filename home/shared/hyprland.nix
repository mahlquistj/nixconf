{
  inputs,
  sysOptions,
  wallpapers,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${wallpapers}/${sysOptions.wallpaper}.png"];
      wallpaper = [", ${wallpapers}/${sysOptions.wallpaper}.png"];
    };
  };
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages."${sysOptions.system}".default;
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

      input-field = {
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.35;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.6)";
        font_family = "Source Code Pro";
        font_color = "$text";
        fade_on_empty = false;
        rounding = -1;
        check_color = "$peach";
        fail_color = "$red";
        capslock_color = "$yellow";
        placeholder_text = "Input Password...";
        hide_input = false;
        position = "0, -100";
        halign = "center";
        valign = "center";
      };

      label = [
        # DATE
        {
          text = ''cmd[update:1000] date +"%A, %d %B"'';
          color = "$text";
          font_size = 18;
          font_family = "JetBrains Mono";
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
        # TIME
        {
          text = ''cmd[update:1000] date +"%H:%M"'';
          color = "$subtext1";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    plugins = [];

    settings = {
      # Important keys
      "$mod" = "SUPER";
      "$modshift" = "SUPER SHIFT";
      "$modalt" = "SUPER ALT";
      "$modctl" = "SUPER CTRL";

      # Apps
      "$terminal" = "rio";
      "$fileman" = "nemo";
      "$menu" = "rofi -show drun";
      "$browser" = "firefox";
      "$lock" = "hyprlock";

      # Startup
      exec-once = [
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP"
        "dbus-update-activation-environment --systemd --all WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE XDG_SESSION_DESKTOP"
        "swaync"
      ];

      # Setttings and styling
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        resize_on_border = true;

        # col.* has to be in quotes
        "col.active_border" = "$peach";
        "col.inactive_border" = "$base";
      };
      decoration = {
        rounding = 10;
        #rounding_power = 2.5; #TODO: Why doesn't this work?

        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.1;
      };
      input = {
        kb_layout = "us";
        kb_options = "compose:ralt";
      };
      gestures = {workspace_swipe = true;};
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
}
