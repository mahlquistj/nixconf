{
  pkgs,
  nurpkgs,
  sysOptions,
  ...
}: {
  imports = [
    ./audio.nix
    ./display_manager.nix
    ./fonts.nix
    ./hyprland.nix
    ./network.nix
    ./programs.nix
    ./shell.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/configuration.nix
  ];

  hardware.keyboard.zsa.enable = true;

  nixpkgs.overlays = [nurpkgs.overlays.default];

  # Location
  location.provider = "geoclue2";

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
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_SCALE = 1;

    NIXOS_XDG_USE_PORTAL = 1;
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };
}
