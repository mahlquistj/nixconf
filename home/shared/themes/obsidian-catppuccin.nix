{pkgs, ...}:
pkgs.stdenv.mkDerivation rec {
  pname = "obsidian.themes.catppuccin";
  version = "";

  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obsidian";
    rev = "065101797eb32eea61ef7b6690e7b9ff7cbf08d9";
    hash = "sha256-sN5k263geOtJ1mOCQGM8UdmA/71OhBI5NRwGxJwd80E=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs_24
    pnpm.configHook
  ];

  pnpmDeps = pkgs.pnpm.fetchDeps {
    inherit pname version src;
    fetcherVersion = 2;
    hash = "sha256-rPaN7FlYyo1lMTd+9hd6GYov68IHMAO/3YLnL4H2b/0=";
  };

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out
    cp ./dist/catppuccin.css $out/theme.css
    cp ./manifest.json $out/manifest.json
  '';
}
