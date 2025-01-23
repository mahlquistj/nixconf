{ colors, has_battery, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      position = "top";
      layer = "top";

      mod = "dock";

      margin-left = 10;
      margin-right = 10;
      margin-top = 7;
      margin-bottom = 0;
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      reload_style_on_change = true;

      modules-left =
        [ "custom/smallspacer" "hyprland/workspaces" "custom/spacer" "mpris" ];
      modules-center = [ ];
      modules-right = [ ];

      smallspacer = { "format" = " "; };

      "hyprland/workspaces" = { format = ""; };

    }];

    style = ''
      :root {
        --background: ${colors.background};
        --color1: ${colors.color1};
      }

      ${builtins.readFile ./waybar.css}
    '';
  };
}
