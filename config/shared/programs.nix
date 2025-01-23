{ config, pkgs, ... }:

{
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

      # sddm related
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
      (callPackage ../../derivs/sddm-astronaut-theme.nix {
        theme = "japanese_aesthetic";
      })

      # Other
      hyprpaper
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
