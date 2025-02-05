{ ... }: {
  programs.rofi = {
    enable = true;

    location = "center";
    font = "SauceCodePro Nerd Font Mono";

    extraConfig = {
      show-icons = true;
      icon-theme = "Papirus";
      terminal = "ghostty";
      drun-display-format = "{icon} {name}";
      hide-scrollbar = true;
      lines = 5;
      display-drun = " 󱄅 ";
      display-run = " ❯ ";
      display-window = "  ";
    };
  };
}
