{ customUtils, ... }:
let multiline = customUtils.string.removeNewlines;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      palette = "default";
      fill.symbol = " ";

      format = multiline ''
        [╭](fg:base)
        $username
        $directory

        $git_branch
        $git_status

        $rust

        $fill

        $cmd_duration
        $time

        $line_break

        [╰](fg:base)
        $character
      '';

      username = {
        format = multiline ''
          [](fg:peach)
          [](bg:peach fg:crust)
          [](fg:peach bg:base)
          [ $user]($style)
          [](fg:base)
        '';
        show_always = true;
        style_user = "bg:base";
        style_root = "fg:red  bg:base";
      };

      directory = {
        truncation_symbol = "..";
        read_only = "";
        home_symbol = "";

        style = "bg:base";
        read_only_style = "bg:base fg:red";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = multiline ''
          [─](fg:base)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:base)
          [ $path]($style)
          [$read_only]($read_only_style)
          [](fg:base)
        '';
        repo_root_format = multiline ''
          [─](fg:base)
          [](fg:mauve)
          [](bg:mauve fg:crust)
          [](fg:mauve bg:base)
          [/$repo_root]($style)
          [$path]($style)
          [ $read_only]($read_only_style)
          [](fg:base)
        '';
      };

      git_branch = {
        symbol = "";
        format = multiline ''
          [─](fg:base)
          [](fg:green)
          [$symbol $branch(:$remote_branch)](fg:crust bg:green)
          [](fg:green bg:base)
        '';
      };

      git_status = {
        conflicted = "🚨";
        ahead = "🏎";
        behind = "😰";
        diverged = "😵";
        up_to_date = "[ ✓](bold fg:green bg:base)";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "[ +$count](fg:green bg:base)";
        renamed = "👅";
        deleted = "🗑";

        format = multiline ''
          [$conflicted$stashed$deleted$renamed$modified$typechanged$untracked$staged$ahead_behind](bg:base)
          [](fg:base)
        '';
      };

      cmd_duration = {
        show_notifications = true;
        format = multiline ''
          [](fg:yellow)
          [󱐋](bold fg:crust bg:yellow)
          [](fg:yellow bg:base)
          [ $duration](bg:base)
          [─](fg:base)
        '';
      };

      time = {
        disabled = false;
        format = multiline ''
          [](fg:sapphire)
          [](fg:crust bg:sapphire)
          [](fg:sapphire bg:base)
          [ $time](bg:base)
          [ ](fg:base)
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
