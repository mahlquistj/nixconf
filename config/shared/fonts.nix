{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts-color-emoji
      google-fonts
      nerd-fonts.sauce-code-pro
      jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["Product Sans"];
        monospace = ["SauceCodePro Nerd Font Mono"];
        emoji = ["Noto Color Emoji"];
      };

      useEmbeddedBitmaps = true;
    };

    enableDefaultPackages = true;
  };
}
