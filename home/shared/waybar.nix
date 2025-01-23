{ colors, lib, has_battery, ... }:

let
  # The colors object
  colors = {
    A = "#ff0000";
    background = "#ffffff";
    foreground = "#000000";
  };

  # Function to dynamically replace CSS variables
  importCss = file:
    let
      # Read the CSS file as a string
      cssContent = lib.fileContents file;

      # Replace `var(--<name>)` dynamically
      dynamicReplace = str:
        lib.replaceStringsByRegex "var\\(--([a-zA-Z0-9_-]+)\\)" str (match:
          let
            varName = (builtins.elemAt match
              1); # Extract variable name (e.g., "foreground")
            # Check if the variable exists in `colors` and replace it, otherwise keep it as-is
          in lib.optionalString (lib.hasAttr varName colors)
          "${colors.${varName}}" // "var(--${varName})");

      # Apply the replacement
      transformedCss = dynamicReplace cssContent;
    in transformedCss;

  # Example usage
  waybarStyling = importCss ./styles.css;

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
