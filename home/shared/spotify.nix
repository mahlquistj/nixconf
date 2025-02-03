{ pkgs, spicetify, config, ... }:
let spicePkgs = spicetify.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;
    enabledExtensions = with spicePkgs.extensions; [ fullAppDisplay shuffle ];
    enabledCustomApps = with spicePkgs.apps; [ new-releases ];
  };
}
