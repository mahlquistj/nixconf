{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Cursor
    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";

    # Color scheme
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { self, nixpkgs, catppuccin, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      wallpapers = "${self}/media/wallpaper";
      style = import ./style.nix { };
      lib = nixpkgs.lib;
      customUtils = import ./custom_utils.nix { inherit lib style; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      default_modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        {
          catppuccin = {
            enable = true;
            flavor = "macchiato";
          };
        }
      ];

      default_hm_modules = [
        catppuccin.homeManagerModules.catppuccin
        {
          catppuccin = {
            enable = true;
            flavor = "macchiato";
          };
        }
      ];

      system_options =
        { # TODO: How can we make this better, so that we don't have to *merge* it into specialArgs every time we run the flake?
          work = {
            has_battery = true;
            wallpaper = "normal";
            cursorSize = 18;
          };
          desktop = {
            has_battery = false;
            wallpaper = "ultrawide";
            cursorSize = 24;
          };
        };
    in {
      nixosConfigurations = {
        work = pkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style customUtils;
          } // {
            sysOptions = system_options.work;
          };
          modules = default_modules ++ [
            ./config/work
            {
              home-manager.users.maj.imports = default_hm_modules
                ++ [ ./home/work.nix ];
            }
          ];
        };

        desktop = pkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style customUtils;
          } // {
            sysOptions = system_options.desktop;
          };
          modules = default_modules ++ [
            ./config/desktop
            {
              home-manager.users.maj.imports = default_hm_modules
                ++ [ ./home/desktop.nix ];
            }
          ];
        };
      };
    };
}
