{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      twemoji-color-font
      google-fonts
      nerdfonts
      jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Product Sans" ];
        monospace = [ "SauceCodePro Nerd Font Mono" ];
      };
    };

    enableDefaultPackages = true;
  };
}
