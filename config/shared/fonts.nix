{pkgs, ...}: {
  nixpkgs.config.joypixels.acceptLicense = true;
  fonts = {
    packages = with pkgs; [
      twitter-color-emoji
      joypixels
      google-fonts
      nerd-fonts.sauce-code-pro
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Product Sans"];
        monospace = ["Source Code Pro"];
        emoji = ["JoyPixels"];
      };

      useEmbeddedBitmaps = true;
    };

    enableDefaultPackages = true;
  };
}
