{
  pkgs,
  myLib,
  sysOptions,
  ...
}: let
  multiline = myLib.string.removeNewlines;
in {
  programs.starship = {
    enable = true;
    package = pkgs.starship;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      fill.symbol = " ";

      format = multiline ''
        [╭](fg:surface0)
        $nix_shell
        $username
        $directory
        $git_branch
        $git_status
        $rust
        $perl
        $php
        $python
        $terraform
        $fill
        $cmd_duration
        $time
        $line_break
        [╰](fg:surface0)
        $character
      '';

      nix_shell = {
        format = multiline ''
          [](fg:mantle)
          [$symbol](bg:mantle fg:sapphire)
          [](fg:mantle)
          [─](fg:surface0)
        '';
        symbol = "";
      };

      username = {
        format = multiline ''
          [](fg:peach)
          [$user](bg:peach fg:crust)
          [](fg:peach)
        '';
        show_always = true;
        style_user = "bg:peach fg:crust";
        style_root = "bg:red fg:crust";
        aliases = {
          ${sysOptions.user} = "";
          root = "";
        };
      };

      directory = {
        truncation_symbol = "..";
        read_only = " ";
        home_symbol = "";

        style = "bg:surface0";
        read_only_style = "bg:surface0 fg:red";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = multiline ''
          [─](fg:surface0)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:surface0)
          [ $path]($style)
          [$read_only]($read_only_style)
          [](fg:surface0)
        '';
        repo_root_format = multiline ''
          [─](fg:surface0)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:surface0)
          [ $repo_root$path]($style)
          [$read_only]($read_only_style)
          [](fg:surface0)
        '';
      };

      git_branch = {
        symbol = "";
        format = multiline ''
          [─](fg:surface0)
          [](fg:green)
          [$symbol $branch(:$remote_branch)](fg:crust bg:green)
          [](fg:green bg:surface0)
        '';
      };

      git_status = {
        conflicted = " [](fg:red bg:surface0)";
        ahead = " [](fg:teal bg:surface0)";
        behind = " [](fg:peach bg:surface0)";
        diverged = " [](fg:yellow bg:surface0)";
        up_to_date = "[ ](bold fg:green bg:surface0)";
        untracked = " [](fg:overlay2 bg:surface0)";
        stashed = " [](fg:mauve bg:surface0)";
        modified = " [](fg:yellow bg:surface0)";
        staged = "[ +$count](fg:green bg:surface0)";
        renamed = " [](fg:blue bg:surface0)";
        deleted = " [](fg:red bg:surface0)";

        format = multiline ''
          [$conflicted$stashed$deleted$renamed$modified$typechanged$untracked$staged$ahead_behind](bg:surface0)
          [](fg:surface0)
        '';
      };

      rust = {
        symbol = "";
        format = multiline ''
          [─](fg:surface0)
          [](fg:mantle)
          [$symbol](bg:mantle fg:peach)
          [](fg:mantle bg:surface0)
          [ $version](bg:surface0)
          [](fg:surface0)
        '';
      };

      perl = {
        symbol = "";
        format = multiline ''
          [─](fg:surface0)
          [](fg:mantle)
          [$symbol](bg:mantle fg:teal)
          [](fg:mantle bg:surface0)
          [ $version](bg:surface0)
          [](fg:surface0)
        '';
      };

      php = {
        symbol = "";
        format = multiline ''
          [─](fg:surface0)
          [](fg:mantle)
          [$symbol](bg:mantle fg:lavender)
          [](fg:mantle bg:surface0)
          [ $version](bg:surface0)
          [](fg:surface0)
        '';
      };

      python = {
        symbol = "";
        format = multiline ''
          [─](fg:surface0)
          [](fg:mantle)
          [$symbol](bg:mantle fg:blue)
          [](fg:mantle bg:surface0)
          [ $pyenv_prefix$version(\($virtualenv\))](bg:surface0)
          [](fg:surface0)
        '';
        pyenv_prefix = "pyenv-";
      };

      cmd_duration = {
        format = multiline ''
          [](fg:yellow)
          [󱐋](bold fg:crust bg:yellow)
          [](fg:yellow bg:surface0)
          [ $duration](bg:surface0)
          [─](fg:surface0)
        '';
      };

      time = {
        disabled = false;
        format = multiline ''
          [](fg:blue)
          [](fg:crust bg:blue)
          [](fg:blue bg:surface0)
          [ $time](bg:surface0)
          [ ](fg:surface0)
        '';
      };

      character = {
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:yellow)";
        vimcmd_replace_symbol = "[❮](bold fg:yellow)";
        vimcmd_visual_symbol = "[❮](bold fg:mauve)";
      };
    };
  };
}
