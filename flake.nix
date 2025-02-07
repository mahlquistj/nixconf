{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Cursor
    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";

    # Color scheme
    catppuccin.url = "github:catppuccin/nix";

    # Spotify themes
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    { self, nixpkgs, catppuccin, spicetify-nix, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      wallpapers = "${self}/media/wallpaper";
      style = import ./style.nix { };
      customUtils = import ./custom_utils.nix {
        lib = nixpkgs.lib;
        style = style;
      };

      default_modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          catppuccin = {
            enable = true;
            flavor = "mocha";
          };
        }
        ./config/shared
      ];

      default_hm_modules = [
        catppuccin.homeManagerModules.catppuccin
        spicetify-nix.homeManagerModules.spicetify
        {
          catppuccin = {
            enable = true;
            flavor = "mocha";
          };
        }
        ./home/shared
      ];

      sysOptions =
        { # TODO: How can we make this better, so that we don't have to *merge* it into specialArgs every time we run the flake?
          work = {
            user = "maj";
            has_battery = true;
            wallpaper = "1920x1200";
            cursorSize = 18;
          };
          desktop = {
            user = "maj";
            has_battery = false;
            wallpaper = "3440x1440";
            cursorSize = 18;
          };
        };

      args = {
        inherit inputs outputs self wallpapers style customUtils spicetify-nix;
      };
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = args // { sysOptions = sysOptions.work; };
          modules = default_modules ++ [
            ./config/work
            {
              home-manager = {
                extraSpecialArgs = args // { sysOptions = sysOptions.work; };
                users.${sysOptions.work.user}.imports = default_hm_modules
                  ++ [ ./home/work.nix ];
              };
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = args { sysOptions = sysOptions.desktop; };
          modules = default_modules ++ [
            ./config/desktop
            {
              home-manager = {
                extraSpecialArgs = args // { sysOptions = sysOptions.desktop; };
                users.${sysOptions.desktop.user}.imports = default_hm_modules
                  ++ [ ./home/desktop.nix ];
              };
            }
          ];
        };
      };
    };
}
