{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.chromium.override {enableWideVine = true;};

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];

    extensions = [
      {id = "fdjamakpfbbddfjaooikfcpapjohcfmg";} # Dashlane
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # Vimium
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
    ];
  };

  xdg = {
    enable = true;
    mimeApps.defaultApplications = {
      "text/html" = "chromium-browser.desktop";
      "x-scheme-handler/http" = "chromium-browser.desktop";
      "x-scheme-handler/https" = "chromium-browser.desktop";
      "x-scheme-handler/about" = "chromium-browser.desktop";
      "x-scheme-handler/unknown" = "chromium-browser.desktop";
    };
  };
}
