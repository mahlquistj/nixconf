{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-24.11";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Color scheme
    catppuccin.url = "github:catppuccin/nix";

    # Spotify themes
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;

      utilities =
        import ./utilities.nix { inherit self nixpkgs inputs outputs; };
    in {
      nixosConfigurations = {
        work = utilities.mkSystem {
          name = "work";
          battery = true;
        };

        desktop = utilities.mkSystem {
          name = "desktop";
          wallpaper = "3440x1440";
        };
      };
    };
}
