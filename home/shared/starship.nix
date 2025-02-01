{ style, customUtils, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = (customUtils.string.removeNewlines ''
        [](fg:#${style.background})
        $username
        $directory
        [](fg:#${style.background} bg:#${style.success})
        $git_branch
        $git_status
        $rust
      '') + ''

        $character'';

      right_format = customUtils.string.removeNewlines ''
        [](fg:#${style.secondary})
        [󰅒 ](bg:#${style.secondary})
        $cmd_duration
        $time
        [](fg:#${style.style.darker})
      '';

      add_newline = true;

      username = {
        format = "[ $user]($style)";
        show_always = true;
        style_user = "bg:#${style.background}";
        style_root = "bg:#${style.background} fg:#${style.danger}";
      };

      directory = {
        style = "#${style.background}";
        read_only_style = "bg:#${style.background} fg:#${style.danger}";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = "[$path](bg:$style)[ $read_only]($read_only_style)";
        repo_root_format =
          "[/$repo_root](bg:$style)[$path](bg:$style)[$read_only]($read_only_style)";
        truncation_symbol = "..";
        read_only = "🔒";
        home_symbol = "󰠦";
      };

      character = {
        success_symbol = "[❯](bold fg:#${style.success})";
        error_symbol = "[❯](bold fg:#${style.danger})";
        vimcmd_symbol = "[❮](bold fg:#${style.success})";
        vimcmd_replace_one_symbol = "[❮](bold fg:#${style.secondary})";
        vimcmd_replace_symbol = "[❮](bold fg:#${style.secondary})";
        vimcmd_visual_symbol = "[❮](bold fg:#${style.caution})";
      };

      cmd_duration = {
        show_milliseconds = true;
        show_notifications = true;

        style = "bg:#${style.background}";
        format =
          "[ $duration]($style)[](fg:#${style.background} bg:#${style.darker})";
      };

      time = {
        disabled = false;

        style = "bg:#${style.darker}";
        format = "[$time]($style)";
      };

    };
  };
}
