{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./display_manager.nix
    ./fonts.nix
    ./hyprland.nix
    ./programs.nix
    ./shell.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/configuration.nix
  ];

  # Location
  location.provider = "geoclue2";

  # Enable networking
  networking.networkmanager.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;

  security = {
    polkit.enable = true;
    pam.services.hyprlock = {};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_SCALE = "1";
  };
}
