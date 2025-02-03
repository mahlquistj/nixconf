{ pkgs, spicetify-nix, ... }:
let spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with spicePkgs.extensions; [ fullAppDisplay shuffle ];
    enabledCustomApps = with spicePkgs.apps; [ newReleases ];
  };
}
