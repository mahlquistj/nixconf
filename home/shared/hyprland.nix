{ sysOptions, wallpapers, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${wallpapers}/${sysOptions.wallpaper}.png" ];
      wallpaper = [ ", ${wallpapers}/${sysOptions.wallpaper}.png" ];
    };
  };
  programs.hyprlock = {
    enable = true;
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

    plugins = [ ];

    settings = {
      # Important keys
      "$mod" = "SUPER";
      "$modshift" = "SUPER SHIFT";

      # Apps
      "$terminal" = "ghostty";
      "$fileman" = "nemo";
      "$menu" = "rofi -show drun";
      "$browser" = "firefox";

      # Startup
      exec-once = [ "waybar" "$terminal" ];

      # Setttings and styling
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        "col.active_border" = "$peach";
        "col.inactive_border" = "$base";

        resize_on_border = true;
      };
      decoration = {
        rounding = 10;
        #rounding_power = 2.5; #TODO: Why doesn't this work?

        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.2;
      };
      input = { kb_layout = "dk"; };
      gestures = { workspace_swipe = true; };
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
      };

      # Bindings
      binde = [
        # Volume up/down
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
        # Brightness up/down
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];
      bind = [
        # Important controls
        "$mod, ESCAPE, exec, hyprlock"
        "$modshift, ESCAPE, exit"

        # Spawners
        "$mod, Return, exec, $terminal"
        "$mod, W, exec, $browser"
        "$mod, F, exec, $fileman"
        "$mod, R, exec, $menu"
        "$mod, D, exec, echo $PATH && whoami" # DEBUG

        # Moving windows
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
        "$modshift, V, togglefloating"
        "$modshift, J, togglesplit"
        "$modshift, F, fullscreen"
        "$modshift, Q, killactive"

        # Screenshotting
        "$mod, PRINT, exec, hyprshot -m window"
        ", PRINT, exec, hyprshot -m output"
        "$modshift, PRINT, exec, hyprshot -m region"

        # Volume mute
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # Microphone mute
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${
              toString ws
            }" # Switch workspace
            "$modshift, code:1${toString i}, movetoworkspace, ${
              toString ws
            }" # Move window to workspace
          ]) 9));
    };

    extraConfig = ''
      # Hyprcursor theme
      env = HYPRCURSOR_THEME,phinger-cursors-light
      env = HYPRCURSOR_SIZE,${builtins.toString sysOptions.cursorSize}
      env = XCURSOR_SIZE,${builtins.toString sysOptions.cursorSize}
      env = HYPRSHOT_DIR,screenshots
      env = PATH,/home/${sysOptions.user}/.nix-profile/bin:/run/current-system/sw/bin:$PATH
    '';
  };
}
