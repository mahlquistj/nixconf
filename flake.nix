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
      wallpapers = "${self}/.media/wallpapers";
      colors = import ./colors.nix { };
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs wallpapers colors; };
          modules = [ inputs.home-manager.nixosModule ./config/work ];
        };
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs wallpapers colors; };
          modules = [ inputs.home-manager.nixosModule ./config/desktop ];
        };
      };

      homeConfigurations = {
        work = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs outputs self colors; };
          modules = [ ./home/work.nix ];
        };

        desktop = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs outputs self colors; };
          modules = [ ./home/home.nix ];
        };
      };

    };
}
