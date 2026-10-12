{ pkgs, ... }:
# DEPRECATED -- no longer wired into programs.obsidian (see ./obsidian.nix).
# Kept for reference: Team Relay (id: team-relay) was the EVC beta plugin
# (https://github.com/entire-vc/evc-team-relay-plugin), replaced by the community
# plugin Relay (./relay.nix, id: system3-relay).
#
# To bump: change `version`, set every hash to lib.fakeSha256, then read the
# `wanted: sha256-...` values from a failing `nix build` of this file.
let
  owner = "entire-vc";
  repo = "evc-team-relay-plugin";
  version = "0.0.29";

  fetchAsset =
    name: hash:
    pkgs.fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/${version}/${name}";
      inherit name hash;
    };

  mainJs = fetchAsset "main.js" "sha256-zfDOiAzLONRECjPBOcziY+hRrsZ4bVzaurok8n0b9g4=";
  manifestJson = fetchAsset "manifest.json" "sha256-4ZHuoXSKRPEpc8u/jUlBtLdtb3JtQ+GJTnQDdl8nprI=";
  stylesCss = fetchAsset "styles.css" "sha256-7zS0IdhRIpJBehmrpLxXZXE7rh+eoPbWAszQNSggJb0=";
in
pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-team-relay";
  inherit version;

  # These are prebuilt release assets (a beta plugin, still pending the community
  # listing), so there is nothing to configure or build.
  dontConfigure = true;
  dontBuild = true;

  phases = [
    "installPhase"
    "fixupPhase"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    cp ${mainJs} "$out/main.js"
    cp ${manifestJson} "$out/manifest.json"
    cp ${stylesCss} "$out/styles.css"

    # Home Manager names the vault plugin directory from this id, so fail early
    # if an upstream release ever renames it.
    grep -q '"id"[[:space:]]*:[[:space:]]*"team-relay"' "$out/manifest.json"

    runHook postInstall
  '';

  # The vault plugin dir will be .obsidian/plugins/team-relay/
  passthru = {
    manifestId = "team-relay";
    deprecated = true;
    replacement = ./relay.nix;
  };

  meta = {
    description = "DEPRECATED: Team Relay (entire-vc) -- superseded by community plugin Relay (system3-relay)";
    homepage = "https://github.com/${owner}/${repo}";
    changelog = "https://github.com/${owner}/${repo}/releases/tag/${finalAttrs.version}";
    license = pkgs.lib.licenses.mit;
    platforms = pkgs.lib.platforms.all;
  };
})
