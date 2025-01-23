{ inputs, config, lib, pkgs, colors, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ ];

    settings = {
      "$mod" = "SUPER";
      "$modshift" = "$mod SHIFT";

      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun";

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        "col.active_border" = "rgba(${colors.color1}ee)";
        "col.inactive_border" = "rgba(${colors.color0}aa)";
      };

      bind = [
        # Spawners
        "$mod, ENTER, exec, $terminal"
        "$mod, W, exec, firefox"

        # Moving windows
        "$mod, left, movefocus, l"
        "$mod, right, movefocu, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

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
