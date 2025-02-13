{ pkgs, sysOptions, ... }: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      vimAlias = true;
      viAlias = true;

      globals = { mapleader = ","; };

      options = {
        tabstop = 4;
        shiftwidth = 4;
      };

      telescope.enable = true;
      spellcheck.enable = true;

      filetree.nvimTree.enable = true;

      statusline.lualine = {
        enable = true;
        refresh.statusline = 100;
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        python.enable = true;
        rust.enable = true;
      };

      formatter.conform-nvim.enable = true;

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
