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

      utility = {
        surround.enable = true;
        yazi-nvim = {
          enable = true;
          mappings = {
            openYazi = "<leader>cc";
            openYaziDir = "<leader>cd";
            yaziToggle = "<leader>cl";
          };
          setupOpts = {
            open_for_directories = true;
          };
        };
      };

      git.enable = true;

      telescope = {
        enable = true;
      };

      statusline.lualine = {
        enable = true;
        refresh.statusline = 100;
      };

      autocomplete.blink-cmp = {
        enable = true;
        sourcePlugins.emoji.enable = true;
      };

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

        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
        rust = {
          enable = true;
          format.package = pkgs.rust-bin.stable.latest.rustfmt;
          lsp.package = pkgs.rust-bin.stable.latest.rust-analyzer;

          crates = {
            enable = true;
            codeActions = true;
          };
        };

        css.enable = true;
        ts.enable = true;
        nix.enable = true;
        python.enable = true;
        yaml.enable = true;
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
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr })
        '';
    };
  };
}
