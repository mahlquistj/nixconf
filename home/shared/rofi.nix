{...}: {
  programs.rofi = {
    enable = true;

    location = "center";
    font = "SauceCodePro Nerd Font Mono";

    extraConfig = {
      modes = ["drun" "run"];
      show-icons = true;
      icon-theme = "Papirus-Dark";
      terminal = "rio";
      drun-display-format = "{icon} {name}";
      hide-scrollbar = true;
      lines = 5;
      display-drun = " 󱄅 Apps ";
      display-run = " ❯ Run ";
      sidebar-mode = true;
    };
  };
}
