{
  pkgs,
  sysOptions,
  ...
}: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      package = pkgs.neovim-unwrapped;

      vimAlias = true;
      viAlias = true;

      globals = {mapleader = ",";};

      presence.neocord.enable = true;

      ui = {
        breadcrumbs.enable = true;
        noice = {
          enable = true;
          setupOpts.presets.lsp_doc_border = true;
        };
      };

      options = {
        tabstop = 4;
        shiftwidth = 4;
      };

      git.enable = true;

      telescope.enable = true;

      filetree.nvimTree = {
        enable = true;
        setupOpts.git.enable = true;
      };

      statusline.lualine = {
        enable = true;
        refresh.statusline = 100;
      };

      autocomplete.nvim-cmp.enable = true;

      utility.icon-picker.enable = true;

      autopairs.nvim-autopairs.enable = true;

      binds.whichKey = {
        enable = true;
        setupOpts = {
          replace = {
            "<leader>" = "LEADER";
          };
        };
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        lspkind.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        css = {
          enable = true;
          lsp.enable = false; # We don't want LSP as we also use GTK-css, which is a pain when it comes to LSP
          format.enable = true;
          treesitter.enable = true;
        };
        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
        nix.enable = true;
        python.enable = true;
        rust = {
          enable = true;
          format.package = pkgs.rust-bin.stable.latest.rustfmt;
          lsp.package = pkgs.rust-bin.stable.latest.rust-analyzer;

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

      luaConfigPre =
        /*
        lua
        */
        ''
          local ipopts = { noremap = true, silent = true }

          vim.keymap.set("i", "<C-s>", "<CMD>IconPickerInsert emoji<CR>", ipopts)

          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
        '';
    };
  };
}
