{ style, customUtils, ... }:
let
  color = {
    bg = "#${style.background}";
    darker = "#${style.darker}";
  };

  multiline = customUtils.string.removeNewlines;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      fill.symbol = " ";

      format = multiline ''
        [╭](fg:${color.bg})
        [](fg:${color.bg})
        $username
        $directory
        [](fg:${color.bg} bg:#${style.success})
        $git_branch
        $git_status
        [](fg:#${style.success} bg:#${style.primary})
        $rust
        [](fg:#${style.primary})

        $fill

        $cmd_duration
        $time

        $line_break

        [╰](fg:${color.bg})
        $character
      '';

      username = {
        format = "[$user]($style)";
        style_user = "";
        style_root = "bg:${color.bg} fg:#${style.danger}";
      };

      directory = {
        style = "bg:${color.bg}";
        read_only_style = "bg:${color.bg} fg:#${style.danger}";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = "[$path]($style)[ $read_only]($read_only_style)";
        repo_root_format =
          "[/$repo_root]($style)[$path]($style)[$read_only]($read_only_style)";
        truncation_symbol = "..";
        read_only = "";
        home_symbol = "󰠦";
      };

      git_branch = {

      };

      character = {
        success_symbol = "[❯](bold fg:#${style.success})";
        error_symbol = "[](bold fg:#${style.danger})";
        vimcmd_symbol = "[❮](bold fg:#${style.success})";
        vimcmd_replace_one_symbol = "[❮](bold fg:#${style.secondary})";
        vimcmd_replace_symbol = "[❮](bold fg:#${style.secondary})";
        vimcmd_visual_symbol = "[❮](bold fg:#${style.caution})";
      };

      cmd_duration = {
        show_notifications = true;

        style = "bg:${color.bg}";
        format = multiline ''
          [](fg:#${style.secondary})
          [󰅒 ](bg:#${style.secondary})
          [](fg:#${style.secondary} bg:${color.bg})
          [ $duration]($style)
          [─](fg:${color.bg})
        '';
      };

      time = {
        disabled = false;

        style = "bg:${color.bg}";
        format = multiline ''
          [](fg:#${style.caution})
          [󱐋](bold fg:black bg:#${style.caution})
          [](fg:#${style.caution} bg:${color.bg})
          [ $time]($style)
          [ ](fg:${color.bg})
        '';
      };

    };
  };
}
