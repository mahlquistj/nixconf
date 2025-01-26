{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ google-fonts nerdfonts ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Product Sans" ];
        monospace = [ "SauceCodePro Nerd Font" ];
      };
    };

    enableDefaultPackages = true;
  };
}
