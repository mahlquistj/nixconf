{ style, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      format = "[]()$username$directory$git_branch$git_status$rust";

      right_format = "$cmd_duration$time";

      add_newline = false;

      directory = {
        style = "bg:#${style.background}";
        format = "[$path $read_only]($style)";
        truncation_symbol = "..";
      };
    };
  };
}
