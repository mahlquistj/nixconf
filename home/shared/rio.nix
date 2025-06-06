{
  sysOptions,
  inputs,
  ...
}: {
  programs.rio = {
    enable = true;
    package = inputs.rio.packages."${sysOptions.system}".default;
    settings = {
      confirm-before-quit = false;

      cursor = {
        shape = "block";
        blinking = true;
      };

      hide-mouse-cursor-when-typing = true;

      fonts = {
        size = 18;

        regular = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Normal";
          width = "Normal";
          weight = 400;
        };
        bold = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Normal";
          width = "Normal";
          weight = 800;
        };
        italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Italic";
          width = "Normal";
          weight = 400;
        };
        bold-italic = {
          family = "SauceCodePro Nerd Font Mono";
          style = "Italic";
          width = "Normal";
          weight = 800;
        };
      };

      navigation = {
        mode = "Bookmark";
        color-automation = [
          {
            program = "nvim";
            color = "#74c7ec";
          }
        ];
        hide-if-single = true;
      };

      padding-x = 10;
      padding-y = [10 10];

      renderer = {
        performance = "High";
        backend = "Automatic";
      };

      scroll = {
        multiplier = 1;
        divider = 1;
      };

      shell = {
        program = "fish";
        args = [];
      };

      title = {
        content = "{{ TITLE | PROGRAM }}";
        placeholder = "Rio";
      };

      window = {
        opacity = 0.8;
        blur = true;
        decorations = "Disabled";
      };

      working-dir = "/home/${sysOptions.user}";
    };
  };
}
