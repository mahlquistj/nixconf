{
  pkgs,
  nurpkgs,
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
    ./usb.nix
    ./yubikey.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/configuration.nix
  ];

  # Cleanup rules
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  hardware.keyboard.zsa.enable = true;

  nixpkgs.overlays = [nurpkgs.overlays.default];

  # Location
  location.provider = "geoclue2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;

  security = {
    sudo.enable = true;
    polkit.enable = true;
    pam = {
      u2f = {
        enable = true;
        control = "sufficient";
      };
      services = {
        hyprlock.u2fAuth = true;
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    # Editor should always default to neovim
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";

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
