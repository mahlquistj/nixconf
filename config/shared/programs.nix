{ config, pkgs, ... }:

{
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
      hyprcursor
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
