{ pkgs, ... }:
# Excalidraw (community id: obsidian-excalidraw-plugin) -- sketching/drawing.
# https://community.obsidian.md/plugins/obsidian-excalidraw-plugin
# Upstream repo: https://github.com/zsviczian/obsidian-excalidraw-plugin
#
# To bump: change `version`, set every hash to lib.fakeSha256, then read the
# `wanted: sha256-...` values from a failing `nix build` of this file.
# Release notes: https://github.com/zsviczian/obsidian-excalidraw-plugin/releases
let
  version = "2.29.0";
in
(pkgs.callPackage ./mkObsidianPlugin.nix { }) {
  pname = "obsidian-excalidraw";
  pluginId = "obsidian-excalidraw-plugin";
  owner = "zsviczian";
  repo = "obsidian-excalidraw-plugin";
  inherit version;
  description = "Excalidraw: create, edit and view Excalidraw drawings in Obsidian";
  homepage = "https://github.com/zsviczian/obsidian-excalidraw-plugin";
  # main.js is ~5 MB (bundles the Excalidraw web app).
  assets = {
    "main.js" = "sha256-TaIISk6v59MoSE+ldCAEufuZA0bEyE/ekkuIWl7MHBc=";
    "manifest.json" = "sha256-SIC4hcUGQ++EjTHOqCl3bKLpZ0c1Ou4zTXHodfedMcA=";
    "styles.css" = "sha256-Fz6cFhoBxTs8FzNE4CPeTTJ/0GWOR2lhtGsOapMRfe0=";
  };
}
