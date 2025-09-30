_: {
  catppuccin.vesktop.enable = false;
  programs.vesktop = {
    enable = true;

    # https://github.com/Vencord/Vesktop/blob/main/src/shared/settings.d.ts
    settings = {
      discordBranch = "stable";
      tray = true;
      minimizeToTray = true;
      staticTitle = true;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      appBadge = false;
      customTitleBar = false;

      transparencyOption = "mica";
      transparent = true;
      splashTheming = true;
    };

    vencord = {
      settings = {
        autoUpdate = false;
        enabledThemes = ["custom.css"];
        frameless = true;
        transparent = true;
      };

      themes = {
        "custom" = ./themes/vesktop-test.css;
      };
    };
  };
}
