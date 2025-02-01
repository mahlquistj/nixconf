{ style, customUtils, ... }:
let
  color = {
    # Basic colors
    bg = "#${style.background}";
    dark = "#${style.darker}";

    # Warnings
    user_root = "#${style.danger}";
    read_only = "#${style.danger}";

    # Module specific
    git = "#${style.success}";
    lang = "#${style.primary}";
    time = "#${style.secondary}";
    duration = "#${style.caution}";

    # Character
    ch_success = "#${style.success}";
    ch_error = "#${style.danger}";
    ch_vim = "#${style.success}";
    ch_vros = "#${style.secondary}";
    ch_vrs = "#${style.secondary}";
    ch_vvs = "#${style.caution}";
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
        [](fg:${color.bg} bg:${color.git})
        $git_branch
        $git_status
        [](fg:${color.git} bg:${color.lang})
        $nix
        $rust
        [](fg:${color.lang})

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
        style_root = "bg:${color.bg} fg:${color.user_root}";
      };

      directory = {
        truncation_symbol = "..";
        read_only = " ";
        home_symbol = "󰠦";

        style = "bg:${color.bg}";
        read_only_style = "bg:${color.bg} fg:${color.read_only}";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format = multiline ''
          [$path]($style)
          [ $read_only]($read_only_style)
        '';
        repo_root_format = multiline ''
          [/$repo_root]($style)
          [$path]($style)
          [$read_only]($read_only_style)
        '';
      };

      git_branch = {
        symbol = "";
        format =
          "[$symbol$branch(:$remote_branch)](fg:${color.dark} bg:${color.git})";
      };

      character = {
        success_symbol = "[❯](bold fg:${color.ch_success})";
        error_symbol = "[](bold fg:${color.ch_error})";
        vimcmd_symbol = "[❮](bold fg:#${color.ch_vim})";
        vimcmd_replace_one_symbol = "[❮](bold fg:#${color.ch_vros})";
        vimcmd_replace_symbol = "[❮](bold fg:#${color.ch_vrs})";
        vimcmd_visual_symbol = "[❮](bold fg:#${color.ch_vvs})";
      };

      cmd_duration = {
        show_notifications = true;
        format = multiline ''
          [](fg:${color.duration})
          [󱐋](bold fg:${color.dark} bg:${color.duration})
          [](fg:${color.duration} bg:${color.bg})
          [ $duration](bg:${color.bg})
          [─](fg:${color.bg})
        '';
      };

      time = {
        disabled = false;
        format = multiline ''
          [](fg:${color.time})
          [󰅒 ](bold fg:${color.dark} bg:${color.time})
          [](fg:${color.time} bg:${color.bg})
          [ $time](bg:${color.bg})
          [ ](fg:${color.bg})
        '';
      };

    };
  };
}
