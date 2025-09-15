{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprlock
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Color scheme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify themes
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim configuration
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repository
    nurpkgs = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rio terminal
    rio = {
      url = "github:raphamorim/rio/3a51a09924016670e0982b6785233a171e8fdb48";
    };

    # Rust overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Octotype
    octotype = {
      url = "github:mahlquistj/octotype";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fancontrol-gui.url = "github:Maldela/fancontrol-gui";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;

    utilities =
      import ./utilities.nix {inherit self nixpkgs inputs outputs;};
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
