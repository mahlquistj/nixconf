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
      style = import ./style.nix { };
      default_modules = [
        inputs.home-manager.nixosModule
        { home-manager.useGlobalPkgs = true; }
      ];
      system_options =
        { # TODO: How can we make this better, so that we don't have to *merge* it into specialArgs every time we run the flake?
          work = {
            has_battery = true;
            wallpaper = "normal";
            cursorSize = 20;
          };
          desktop = {
            has_battery = false;
            wallpaper = "ultrawide";
            cursorSize = 24;
          };
        };
    in {
      # Allow unfree packages globally
      pkgs.config.allowUnfree = true;

      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style;
          } // {
            sysOptions = system_options.work;
          };
          modules = default_modules ++ ./config/work;
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs self wallpapers style;
          } // {
            sysOptions = system_options.desktop;
          };
          modules = default_modules ++ ./config/desktop;
        };
      };

      homeConfigurations = {
        work = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers style;
          } // {
            sysOptions = system_options.work;
          };
          modules = [ ./home/work.nix ];
        };

        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs self wallpapers style;
          } // {
            sysOptions = system_options.desktop;
          };
          modules = [ ./home/home.nix ];
        };
      };

    };
}
