{pkgs-stable, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs-stable.chromium.override {enableWideVine = true;};

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];

    extensions = [
      {id = "fdjamakpfbbddfjaooikfcpapjohcfmg";} # Dashlane
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # Vimium
      {id = "leohhkagdnmgbpfbnflhjmnpcjpcjmgm";} # Vimium new tab
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
    ];
  };

  xdg = {
    enable = true;
  };
}
