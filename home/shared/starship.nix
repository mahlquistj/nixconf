{ style, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format =
        "[](fg:#${style.background})$username$directory$git_branch$git_status$rust ";

      right_format = "$cmd_duration$time";

      add_newline = true;

      username = {
        format = "[$user  ]($style)";
        show_always = true;
        style = "bg:#${style.background}";
        style_user = "bg:#${style.background}";
        style_root = "bg:#${style.background} fg:#${style.danger}";
      };

      directory = {
        style = "#${style.background}";
        read_only_style = "bg:#${style.background} fg:#${style.danger}";
        before_repo_root_style = "none";
        repo_root_style = "none";
        format =
          "[$path](bg:$style)[ $read_only]($read_only_style)[](fg:$style)";
        repo_root_format =
          "[/$repo_root](bg:$style)[$path](bg:$style)[$read_only]($read_only_style)[](fg:$style)";
        truncation_symbol = "..";
        read_only = "🔒";
        home_symbol = "󰠦";
      };
    };
  };
}
