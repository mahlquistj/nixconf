{ osConfig, style, lib, sysOptions, ... }:

let
  # Function to dynamically replace CSS variables
  importCss = file:
    let
      # Read the CSS file as a string
      cssContent = lib.fileContents file;

      # Find all occurrences of `var(--<name>)` and replace them dynamically
      dynamicReplace = str:
        let
          # Extract all potential matches for `var(--<name>)` using a basic regex simulation
          matches = lib.splitString "var(--" str;

          # Process each match except the first (since it's the part before the first match)
          processed = lib.concatStringsSep "" (builtins.concatMap (part:
            let
              # Extract the variable name up to the first `)`
              rest = lib.splitString ")" part;
              varName = builtins.head rest;
              remaining = builtins.concatStringsSep ")" (builtins.tail rest);

              # Check if the variable exists in `style` and replace it, otherwise keep it as-is
              replacement = if lib.hasAttr varName style then
                "#${style.${varName}}"
              else
                "var(--${varName})";
              # Combine the replacement with the remaining part of the string
            in [ replacement remaining ]) (builtins.tail matches));
          # Reattach the part before the first match
        in builtins.head matches + processed;

      # Apply the replacement
      transformedCss = dynamicReplace cssContent;
    in transformedCss;

  waybarStyling = importCss ./waybar.css;

  # TODO: This resolves to null??? Possibly because of osConfig.hardware?
  bluetooth = if osConfig?hardware?bluetooth?enable then "bluetooth" else "";
  battery = if sysOptions.has_battery then "battery" else "";
in {
  programs.waybar = {
    enable = true;

    style = "${waybarStyling}";

    settings = [{
      position = "top";
      layer = "top";

      mod = "dock";

      height = 27;

      margin-left = 10;
      margin-right = 10;
      margin-top = 5;
      margin-bottom = 0;
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      reload_style_on_change = true;

      modules-left = [ "group/power" "tray" "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "group/hardware" "network" "clock" bluetooth battery ];

      "group/power" = {
        orientation = "horizontal";
        drawer = {
          transition-duration = 500;
          children-class = "other-btns";
          transition-left-to-right = true;
        };
        modules = [
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];
      };

      "custom/quit" = {
          "format" = "󰗼";
          "tooltip" = false;
          "on-click" = "hyprctl dispatch exit";
      };
      "custom/lock" = {
          "format" = "󰍁";
          "tooltip" = false;
          "on-click" = ""; #TODO: Implement lock
      };
      "custom/reboot" = {
          "format" = "󰜉";
          "tooltip" = false;
          "on-click" = "reboot";
      };
      "custom/power" = {
          "format" = "";
          "tooltip" = false;
          "on-click" = "shutdown now";
      };

      tray = {

      };

      "hyprland/workspaces" = { 
        format = "{name}";
      };

      "hyprland/window" = {
        format = "{title}";
        icon = true;
        icon-size = 15;
      };

      "group/hardware" = {
        modules = [
          "disk"
          "memory"
          "cpu"
        ];
      };

      cpu = {
        interval = 10;

        format = "<span color='#ffffff'></span> {icon}";
        format-icons = ["" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
      };

      disk = {
        format = " {percentage_used}% free";
        tooltip-format = "{used} used out of {total} ({free} free)";

        states = {
          "critical" = 90;
          "warning" = 70;
        };
      };

      memory = {
        format = " {used:0.1f}GiB";
        tooltip-format = ''
          RAM: {used:0.1f}GiB of {total:0.1f}GiB used.
          SWAP: {swapUsed:0.1f}GiB of {swapTotal:0.1f}GiB} used.
        '';

        states = {
          "critical" = 80;
          "warning" = 60;
        };
      };

      network = {
        format-ethernet = "󰈁 Connected";
        format-disconnected = "󰤮 Offline";
        format-wifi = "{icon} {essid}";

        tooltip-format-ethernet = "Gw: {gwaddr} | {ipaddr} | Up: {bandwidthUpBytes} Down: {bandwidthDownBytes}";
        tooltip-format-wifi = "{signaldBm} dBm | {ipaddr} | Up: {bandwidthUpBytes} Down: {bandwidthDownBytes}";

        format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];

        #TODO: on_click = "ADD COMMAND TO OPEN NETWORK MANAGER";
      };

      clock = {
        format = "{:%H:%M %d/%m/%Y}";
        tooltip-format = "{:%A | Week: %U}";
      };

      battery = {
        interval = 20;

        format = "{icon}";
        format-good = "{icon} {capacity}%";
        format-warning = "{icon} {capacity}%";
        format-critical = "{icon} {time}";
        
        format-charging = "󱐋 {capacity}%";
        format-charging-good = "󱐋 {capacity}% {time}";
        format-charging-warning = "󱐋 {capacity}% {time}";
        format-charging-critical = "󱐋 {capacity}% {time}";

        format-time = "{H}:{M}";

        states = {
          good = 99;
          warning = 40;
          critical = 20;
        };

        format-icons = [ "󰂃" "󰁽" "󰁿" "󰂁" "󱟢"];
      };

    }];
  };
}
