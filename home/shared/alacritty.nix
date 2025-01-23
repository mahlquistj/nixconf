{ config, lib, pkgs, colors, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };

      background_opacity = 0.95;

      window = {
        padding = {
          x = 10;
          y = 10;
        };

        decorations = "buttonless";
      };

      font = {
        size = 12.0;
        use_thin_strokes = true;

        normal.family = "SauceCodePro Nerd Font";
        bold.family = "SauceCodePro Nerd Font";
        italic.family = "SauceCodePro Nerd Font";
      };

      cursor.style = "Beam";

      shell = { program = "fish"; };

      colors = {
        primary = {
          background = "#${colors.background}";
          foreground = "#${colors.foreground}";
        };
      };
    };
  };
}
