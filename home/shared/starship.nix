{ style, customUtils, ... }:
let
  color = {
    main = "#${style.background}";
    darker = "#${style.darker}";
  };
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      line_break.disabled = false;
      add_newline = true;
      fill.symbol = " ";

      format = customUtils.string.removeNewlines ''
        [╭](fg:${color.main})
        [](fg:${color.main})
        $username
        $directory
        [](fg:${color.main} bg:#${style.success})
        $git_branch
        $git_status
        [](fg:#${style.success} bg:#${style.primary})
        $rust
        [](fg:#${style.primary})
        $fill
        [](fg:#${style.secondary})
        [󰅒 ](bg:#${style.secondary})
        $cmd_duration
        $time
        $line_break
        [╰](fg:${color.main})
        $character
      '';

      username = {
        format = "[$user]($style)";
        style_user = "";
        style_root = "bg:${color.main} fg:#${style.danger}";
      };

      directory = {
        style = "${color.main}";
        read_only_style = "bg:${color.main} fg:#${style.danger}";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = "[$path](bg:$style)[ $read_only]($read_only_style)";
        repo_root_format =
          "[/$repo_root](bg:$style)[$path](bg:$style)[$read_only]($read_only_style)";
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

        style = "bg:${color.main}";
        format = "[ $duration]($style)[](fg:${color.main} bg:${color.darker})";
      };

      time = {
        disabled = false;

        style = "bg:${color.darker}";
        format = "[ $time ]($style)[ ](fg:${color.darker})";
      };

    };
  };
}
