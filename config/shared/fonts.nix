{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [ google-fonts nerdfonts jetbrains-mono ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Product Sans" ];
        monospace = [ "SauceCodePro Nerd Font" ];
      };
    };

    enableDefaultPackages = true;
  };
}
