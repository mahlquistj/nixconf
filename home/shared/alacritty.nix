{ config, lib, pkgs, colors, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };

      window = {
        padding = {
          x = 10;
          y = 10;
        };

        opacity = 0.95;

        decorations = "buttonless";
      };

      font = {
        size = 12.0;

        normal.family = "SauceCodePro Nerd Font";
        bold.family = "SauceCodePro Nerd Font";
        italic.family = "SauceCodePro Nerd Font";
      };

      cursor.style = "Beam";

      terminal = { shell = { program = "fish"; }; };

      colors = {
        primary = {
          background = "#${colors.background}";
          foreground = "#${colors.foreground}";
        };
      };
    };
  };
}
