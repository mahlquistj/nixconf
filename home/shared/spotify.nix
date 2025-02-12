{ pkgs, spicetify-nix, sysOptions, ... }:
let spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = sysOptions.theme;
    enabledExtensions = with spicePkgs.extensions; [ fullAppDisplay shuffle ];
    enabledCustomApps = with spicePkgs.apps; [ newReleases ];
  };
}
