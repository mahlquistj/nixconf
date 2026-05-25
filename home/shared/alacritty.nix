{sysOptions, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 18.0;
        offset = { x = 1; y = 0; };
        normal = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Normal";
        };
        bold = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Normal";
        };
        italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Italic";
        };
        bold_italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Italic";
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };

      window = {
        opacity = 0.8;
        decorations = "none";
        padding = {
          x = 10;
          y = 10;
        };
        dynamic_title = true;
      };

      scrolling = {
        multiplier = 1;
        history = 10000;
      };

      mouse = {
        hide_when_typing = true;
      };

      keyboard.bindings = [
        {
          key = "I";
          mods = "Control|Shift";
          action = "ToggleViMode";
        }
        {
          key = "T";
          mods = "Control|Alt|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "Q";
          mods = "Control|Alt|Shift";
          action = "Quit";
        }
      ];
    };
  };
}
