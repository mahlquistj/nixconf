{ style, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format =
        "[](fg:#${style.background})$username$directory$git_branch$git_status$rust";

      right_format = "$cmd_duration$time";

      add_newline = false;

      directory = {
        style = "#${style.background}";
        format = "[$path $read_only](bg:$style)[](fg:#$style)";
        truncation_symbol = "..";
      };
    };
  };
}
