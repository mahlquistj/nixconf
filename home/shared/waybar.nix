{ inputs, config, lib, pkgs, colors, has_battery, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

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

      "hyprland/workspaces" = {
        format = "{icon} {name}";
        format-icons = {
          default = "";
          active = "";
        };
      };

    }];

    style = ''
      * {
        font-family: "SauceCodePro Nerd Font";
        font-weight: bold; 
        font-size: 10px;
      }

      window#waybar {
        /* Transparent */
      }

      #workspaces {
        box-shadow: none;
        text-shadow: none;
        transition: 0.2s ease;
        padding-left: 4px;
        padding-right: 4px;
        padding-top: 1px;
      }


      #workspaces button {
        background: #${colors.background};
        color: #${colors.color1};
        box-shadow: none;
        text-shadow: none;
        border-radius: 9px;
        transition: 0.3s ease;
        padding-left: 4px;
        padding-right: 4px;
      }

      #workspaces button #name {
        /* display: None; */
      }

      #workspaces button.active {
        background: #${colors.color1};
        color: #${colors.background};
        transition: all 0.3s ease;
        padding-left: 4px;
        padding-right: 4px;
        border-radius: 9px;
        transition: 0.2s ease;
      }

      #workspaces button.active #icon {
        color: #${colors.background};
        margin-right: 5px;
      }

      #workspaces button:hover {
        background: none;
        color: #72D792;
        animation: ws_hover 20s ease-in-out 1;
        transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
      }
    '';
  };
}
