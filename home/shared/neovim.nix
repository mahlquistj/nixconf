{sysOptions, ...}: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      vimAlias = true;
      viAlias = true;

      globals = {mapleader = ",";};

      ui.noice = {
        enable = true;
        setupOpts.presets.lsp_doc_border = true;
      };

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

      lsp = {
        formatOnSave = true;
        lightbulb.enable = true;
        lspkind.enable = true;
        lsplines.enable = true;
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        css = {
          enable = true;
          lsp.enable = false; # We don't want LSP as we also use GTK-css, which is a pain when it comes to LSP
          format.enable = true;
          treesitter.enable = true;
        };
        nix.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          crates = {
            enable = true;
            codeActions = true;
          };
        };
      };

      comments.comment-nvim.enable = true;
      notes.todo-comments.enable = true;

      visuals = {indent-blankline.enable = true;};

      theme = {
        enable = true;
        name = "catppuccin";
        style = sysOptions.theme;
        transparent = true;
      };
    };
  };
}
