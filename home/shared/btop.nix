_: {
  programs.btop = {
    enable = true;

    settings = {
      theme_background = false;
      rounded_corners = true;
      vim_keys = true;
      shown_boxes = "proc cpu mem net gpu0";
      update_ms = "2000";
    };
  };
}
