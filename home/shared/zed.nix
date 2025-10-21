_: {
  programs.zed-editor = {
    enable = true;

    userSettings = {
      buffer_font_family = "SauceCodePro Nerd Font Mono";

      lsp = {
        rust-analyzer = {
          binary.path_lookup = true;
        };
      };

      terminal = {
        font_family = "SauceCodePro Nerd Font Mono";
      };

      vim_mode = true;

      theme = {
        mode = "dark";
        dark = "Catppuccin Mocha";
      };
    };
  };
}
