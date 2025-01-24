{ pkgs, lib, stdenvNoCC, themeConfig ? null, }:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut";
  version = "1.0";

  src = pkgs.fetchFromGitHub {
    owner = "madser123";
    repo = "sddm-astronaut-theme";
    rev = "5b334f0e39326780b5acf568a108b009656e05e2";
    hash = "sha256-JoSOrTJJYThwCKSPBwj9exhejg/ASY6s9iDcJ+zn8ME=";
  };

  dontWrapQtApps = true;
  propagatedBuildInputs = with pkgs.kdePackages; [ qt5compat qtsvg ];

  installPhase = let
    iniFormat = pkgs.formats.ini { };
    configFile = iniFormat.generate "" { General = themeConfig; };

    basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
  in ''
    mkdir -p ${basePath}
    cp -r $src/* ${basePath}
  '' + lib.optionalString (themeConfig != null) ''
    ln -sf ${configFile} ${basePath}/theme.conf.user
  '';

  meta = with lib; {
    description = "Series of modern looking themes for SDDM.";
    homepage = "https://github.com/Keyitdev/sddm-astronaut-theme";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
