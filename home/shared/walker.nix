{...}: {
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      theme = "custom";
    };

    themes."custom" = {
      style = builtins.readFile ./walker.css;
    };
  };
}
