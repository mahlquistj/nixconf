_: {
  services.swaync = {
    enable = true;
    style = ./swaync.css;
    settings = {
      text-empty = "";
      widgets = [
        "title"
        "dnd"
        "volume"
        "inhibitors"
        "notifications"
        "mpris"
      ];
      widget-config = {
        mpris = {
          blur = true;
        };
        volume = {
          label = "";
        };
      };
    };
  };
}
