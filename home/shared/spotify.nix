{
  pkgs,
  spicetify-nix,
  lib,
  sysOptions,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    spotifyPackage = pkgs.spotify;
    theme = spicePkgs.themes.text;
    colorScheme = "Catppuccin" + (pkgs.lib.strings.toSentenceCase sysOptions.theme);
    enabledExtensions = with spicePkgs.extensions; [fullAppDisplay shuffle];
    enabledCustomApps = with spicePkgs.apps; [newReleases];
  };
}
