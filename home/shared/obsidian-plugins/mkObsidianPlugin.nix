{
  lib,
  stdenv,
  fetchurl,
}:
# Generic builder for Obsidian plugins that ship prebuilt release assets
# (main.js, manifest.json, ...). Home Manager's `programs.obsidian` module names
# the vault plugin directory from manifest.json's `id`, hence the `pluginId` arg.
{
  pname,
  pluginId,
  owner,
  repo,
  version,
  description,
  # attrset of release asset filename -> sha256 SRI hash
  assets,
  homepage ? "https://github.com/${owner}/${repo}",
  license ? lib.licenses.mit,
}:
let
  inherit (lib)
    concatStringsSep
    mapAttrsToList
    ;

  assertReq = cond: msg: if cond then true else builtins.throw msg;

  fetched = lib.mapAttrs (
    name: hash:
    fetchurl {
      url = "https://github.com/${owner}/${repo}/releases/download/${version}/${name}";
      inherit name hash;
    }
  ) assets;
in
assert assertReq (builtins.hasAttr "manifest.json" assets) "${pname}: assets must include manifest.json";
assert assertReq (pluginId != "") "${pname}: pluginId must be set";
stdenv.mkDerivation {
  inherit pname version;

  # Prebuilt upstream bundle: nothing to configure or build.
  dontConfigure = true;
  dontBuild = true;

  phases = [
    "installPhase"
    "fixupPhase"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
  '' + concatStringsSep "\n" (
    mapAttrsToList (name: path: ''  cp ${path} "$out/${name}"'') fetched
  ) + ''

    # Fail early if upstream ever renames the plugin id, since that would silently
    # change the vault plugin directory that Home Manager links to.
    grep -qE '"id"[[:space:]]*:[[:space:]]*"${pluginId}"' "$out/manifest.json"

    runHook postInstall
  '';

  passthru = {
    inherit pluginId;
    releasesPage = "https://github.com/${owner}/${repo}/releases";
  };

  meta = {
    inherit description homepage license;
    platforms = lib.platforms.all;
  };
}
