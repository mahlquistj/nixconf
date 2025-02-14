{...}: {
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      rounded_corners = true;
      vim_keys = true;
    };
  };
}
