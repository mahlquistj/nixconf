{ pkgs, sysOptions, ... }: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      vimAlias = true;
      viAlias = true;

      globals = { mapleader = ","; };

      ui.noice.enable = true;

      options = {
        tabstop = 4;
        shiftwidth = 4;
      };

      telescope.enable = true;
      #spellcheck.enable = true;

      filetree.nvimTree.enable = true;

      statusline.lualine = {
        enable = true;
        refresh.statusline = 100;
      };

      autocomplete.nvim-cmp.enable = true;

      lsp.formatOnSave = true;

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        python.enable = true;
        rust.enable = true;
      };

      visuals = { indent-blankline.enable = true; };

      theme = {
        enable = true;
        name = "catppuccin";
        style = sysOptions.theme;
        transparent = true;
      };
    };
  };
}
