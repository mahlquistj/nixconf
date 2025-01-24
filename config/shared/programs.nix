{ config, pkgs, ... }:
let custom-astronaut = (pkgs.callPackage ../../derivs/sddm-astronaut.nix { });
in {
  # Hyprland service needed directly in the config 
  # for the home-manager module to work
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # System packages
  environment = {
    systemPackages = with pkgs; [
      # Essentials
      vim
      wget
      git
      curl
      nixd
      openssl
      home-manager
      wofi
      wev # Keyboard debugging

      # Other
      hyprpaper

      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      custom-astronaut
    ];
  };

  services = {
    # OpenSSH
    openssh.enable = true;

    # Xserver
    xserver = {
      enable = true;
      xkb = {
        layout = "dk";
        variant = "";
      };
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = [
        pkgs.kdePackages.qtsvg
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtvirtualkeyboard
        custom-astronaut
      ];
    };

    redshift = {
      enable = true;
      brightness = {
        day = "1";
        night = "1";
      };
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
  };

}
