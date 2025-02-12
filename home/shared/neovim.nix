{ pkgs, ... }: {
  programs.neovim.enable = true;

  programs.nvf = {
    enable = true;

    settings.vim = {
      vimAlias = true;
      viAlias = true;

      telescope.enable = true;

      spellcheck.enable = true;

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
    };
  };
}
