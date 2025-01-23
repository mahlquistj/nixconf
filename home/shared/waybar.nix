{ colors, lib, has_battery, ... }:

let
  # The colors object
  colors = {
    A = "#ff0000";
    background = "#ffffff";
    foreground = "#000000";
  };

  # Function to dynamically transform CSS
  importCss = file: let
    # Read the CSS file as a string
    cssContent = lib.fileContents file;

    # Replace `var(--<name>)` dynamically with escaped `${}` syntax
    dynamicReplace = str:
      lib.replaceStringsByRegex
        "var\\(--([a-zA-Z0-9_-]+)\\)"
        str
        (match: ''
          ${lib.getAttrFromPath (lib.splitString "." match.[1]) colors or "var(--${match.[1]})"}
        '');
  in
    dynamicReplace cssContent;

  # Example usage
  myCss = importCss ./styles.css;

in {
  programs.waybar = {
    enable = true;

    style = "${waybarStyling}";

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
  };
}
