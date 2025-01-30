{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      wallpapers = "${self}/media/wallpaper";
      style = import ./style.nix { };
      lib = nixpkgs.lib;
      utils = import ./utils.nix { inherit lib style; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      default_modules = [
        inputs.home-manager.nixosModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
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
        work = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style utils;
          } // {
            sysOptions = system_options.work;
          };
          modules = default_modules ++ [ ./config/work ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style utils;
          } // {
            sysOptions = system_options.desktop;
          };
          modules = default_modules ++ [ ./config/desktop ];
        };
      };

      homeConfigurations = {
        work = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers style utils;
          } // {
            sysOptions = system_options.work;
          };
          modules = [ ./home/work.nix ];
        };

        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers style utils;
          } // {
            sysOptions = system_options.desktop;
          };
          modules = [ ./home/home.nix ];
        };
      };

    };
}
