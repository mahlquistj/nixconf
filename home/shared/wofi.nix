{ ... }: {
  programs.wofi = {
    enable = true;

    settings = { key_expand = "End"; };
  };
}
