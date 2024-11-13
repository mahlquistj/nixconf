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
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ inputs.home-manager.nixosModule ];
        };
        home = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ inputs.home-manager.nixosModule ];
        };
      };

      homeConfigurations = {
        work = inputs.home-manager.homeManagerConfiguration {
          pkgs = nixpkgs;
          extraSpecialArgs = { inherit inputs outputs self; };
          modules = [ ./home-manager/namish/home.nix ];
        };

        home = inputs.home-manager.homeManagerConfiguration {
          pkgs = nixpkgs;
          extraSpecialArgs = { inherit inputs outputs self; };
          modules = [ ./home-manager/namish/home.nix ];
        };
      };

    };
}
