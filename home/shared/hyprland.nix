{ inputs, config, lib, pkgs, colors, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ ];

    settings = {
      # Important keys
      "$mod" = "SUPER";
      "$modshift" = "SUPER SHIFT";

      # Apps
      "$terminal" = "alacritty";
      "$fileman" = "nemo";
      "$menu" = "wofi --show drun";
      "$browser" = "firefox";

      # Startup
      exec-once = "$terminal";

      # Setttings and styling
      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        "col.active_border" = "rgba(${colors.color1}ee)";
        "col.inactive_border" = "rgba(${colors.color0}aa)";

        resize_on_border = true;
      };
      decoration = {
        rounding = 2;

        inactive_opacity = 0.9;
        dim_inactive = true;
      };
      input = { kb_layout = "dk"; };
      gestures = {
        workspace_swipe = true;

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

      # Bindings
      bind = [
        # Important controls
        "$modshift, ESCAPE, exit"

        # Spawners
        "$mod, Return, exec, $terminal"
        "$mod, W, exec, $browser"
        "$mod, F, exec, $fileman"
        "$mod, R, exec, $menu"

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
  };
}
