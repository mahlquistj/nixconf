{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      wallpapers = "${self}/media/wallpaper";
      colors = import ./colors.nix { };
      system_vars =
        { # TODO: How can we make this better, so that we don't have to merge it into specialArgs?
          work = {
            has_battery = true;
            wallpaper = "normal";
          };
          desktop = {
            has_battery = false;
            wallpaper = "ultrawide";
          };
        };
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers colors;
          } // system_vars.work;
          modules = [ inputs.home-manager.nixosModule ./config/work ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers colors;
          } // system_vars.desktop;
          modules = [ inputs.home-manager.nixosModule ./config/desktop ];
        };
      };

      homeConfigurations = {
        work = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers colors;
          } // system_vars.work;
          modules = [ ./home/work.nix ];
        };

        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers colors;
          } // system_vars.desktop;
          modules = [ ./home/home.nix ];
        };
      };

    };
}
