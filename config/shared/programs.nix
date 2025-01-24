{ config, pkgs, ... }: {
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
    ];
  };

  systemd.services.hyprpaper = {
    description = "Hyprpaper";
    serviceConfig = {
      ExecStart = "hyprpaper";
      ExecStop = "pkill hyprpaper";
      Restart = "on-failure";
    };
    wantedBy = [ "default.target" ];
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

    displayManager = {
      autoLogin = {
        enable = true;
        user = "maj";
      };
      defaultSession = "hyprland";
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
