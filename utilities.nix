{ self, nixpkgs, inputs, outputs, ... }:
let
  home-manager = inputs.home-manager;
  catppuccin = inputs.catppuccin;
  spicetify-nix = inputs.spicetify-nix;

  myLib = {
    string = {
      removeNewlines = str: builtins.replaceStrings [ "\n" ] [ "" ] str;
    };
  };
in {
  mkSystem = { name, user ? "maj", battery ? false, wallpaper ? "1920x1080"
    , cursorSize ? 18, theme ? "mocha" }:
    let
      sysOptions = { inherit user battery wallpaper cursorSize theme; };

      wallpapers = "${self}/media/wallpaper";

      default_modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          catppuccin = {
            enable = true;
            flavor = "${theme}";
          };
        }
        "${self}/config/shared"
      ];

      default_hm_modules = [
        catppuccin.homeManagerModules.catppuccin
        spicetify-nix.homeManagerModules.spicetify
        {
          catppuccin = {
            enable = true;
            flavor = "${theme}";
          };
        }
        "${self}/home/shared"
      ];

      args = {
        inherit inputs outputs self wallpapers myLib spicetify-nix sysOptions;
      };
    in nixpkgs.lib.nixosSystem {
      specialArgs = args;
      modules = default_modules ++ [
        ./config/${name}
        {
          home-manager = {
            extraSpecialArgs = args;
            users.${user}.imports = default_hm_modules
              ++ [ ./home/${name}.nix ];
          };
        }
      ];
    };
}
