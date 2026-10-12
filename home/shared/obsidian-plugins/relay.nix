{ pkgs, ... }:
# Relay (community id: system3-relay) -- real-time collaboration / live cursors.
# https://community.obsidian.md/plugins/system3-relay
# Upstream repo: https://github.com/No-Instructions/Relay
#
# To bump: change `version`, set every hash to lib.fakeSha256, then read the
# `wanted: sha256-...` values from a failing `nix build` of this file.
let
  version = "0.8.12";
in
(pkgs.callPackage ./mkObsidianPlugin.nix { }) {
  pname = "obsidian-relay";
  pluginId = "system3-relay";
  owner = "No-Instructions";
  repo = "Relay";
  inherit version;
  description = "Relay: collaborate in real time with live cursors, multiplayer folders and access management";
  homepage = "https://relay.md";
  assets = {
    "main.js" = "sha256-hmE95OnlUksYM6U1w1YbLtxxK7qSjxnsFpBHa84T9uc=";
    "manifest.json" = "sha256-ZTdYVOV3evW/vI2G7aG0d7kmQN6rvoYPBrxLmUroqJQ=";
    "styles.css" = "sha256-EkO7ExEP1nc398s+ba4OWy8fYTJkv+u8I3seaKrn1U8=";
  };
}
