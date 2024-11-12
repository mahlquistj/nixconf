{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let inherit (self) outputs;

    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ inputs.home-manager.nixosModule ];
        };
        home = nixpkgs.lib.nixosSystem {
          modules = [ inputs.home-manager.nixosModule ];
        };
      };

      homeConfigurations = {
        work = nixpkgs.lib.nixosSystem {

        };

        home = nixpkgs.lib.nixosSystem {
          modules = [

          ];
        };
      };

    };
}
