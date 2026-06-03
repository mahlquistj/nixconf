{
  self,
  nixpkgs,
  inputs,
  outputs,
  ...
}:
with inputs; let
  myLib = {
    string = {
      removeNewlines = str: builtins.replaceStrings ["\n"] [""] str;
    };
  };
in {
  mkSystem = {
    name,
    user ? "maj",
    battery ? false,
    wallpaper ? "1920x1080",
    cursorSize ? 24,
    theme ? "mocha",
    accent ? "peach",
    cpu_thermal_zone ? 0,
    system ? "x86_64-linux",
  }: let
    sysOptions = {inherit name user battery wallpaper cursorSize theme cpu_thermal_zone system;};

    wallpapers = "${self}/media/wallpaper";

    default_modules = [
      catppuccin.nixosModules.catppuccin
      home-manager.nixosModules.home-manager
      sops-nix.nixosModules.sops
      niri.nixosModules.niri
      {
        nixpkgs.overlays = [
          rust-overlay.overlays.default
          nurpkgs.overlays.default
          nix-citizen.overlays.default
          # Fix nix-citizen's dxvk: withSdl2/withGlfw pull in dependencies that
          # don't support Windows when cross-compiling via mingw32/mingwW64
          (final: prev: {
            dxvk-w32 = prev.dxvk-w32.override {
              withSdl2 = false;
              withGlfw = false;
            };
            dxvk-w64 = prev.dxvk-w64.override {
              withSdl2 = false;
              withGlfw = false;
            };
          })
        ];
        home-manager = {
          useGlobalPkgs = true;
          backupFileExtension = "backup";
        };
        catppuccin = {
          enable = true;
          flavor = "${theme}";
          accent = "${accent}";
        };
      }
      "${self}/config/shared"
    ];

    default_hm_modules = [
      fancontrol-gui.homeManagerModules.default
      catppuccin.homeModules.catppuccin
      spicetify-nix.homeManagerModules.spicetify
      nvf.homeManagerModules.default
      sops-nix.homeManagerModules.sops
      vicinae.homeManagerModules.default
      nix-index-database.homeModules.default
      {
        catppuccin = {
          enable = true;
          flavor = "${theme}";
        };
      }
      "${self}/home/shared"
    ];

    args = {
      inherit inputs outputs self nurpkgs wallpapers myLib spicetify-nix sysOptions;
      pkgs-stable = import pkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = args;
      modules =
        default_modules
        ++ [
          ./config/${name}
          {
            home-manager = {
              extraSpecialArgs = args;
              users.${user}.imports =
                default_hm_modules
                ++ [./home/${name}.nix];
            };
          }
        ];
    };
}
