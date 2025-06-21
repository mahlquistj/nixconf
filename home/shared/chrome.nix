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
}
