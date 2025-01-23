{ inputs, config, lib, pkgs, colors, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [ ];

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "nemo";
      "$menu" = "wofi --show drun";

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        col = {
          active_border = "rgba(${colors.color1}ee)";
          inactive_border = "rgba(${colors.color0}aa)";
        };
      };

      bind = [ "$mod, F, exec, firefox" ", Print, exec, grimblast copy area" ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]) 9));
    };
  };
}
