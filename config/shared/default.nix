{
  pkgs,
  nurpkgs,
  wallpapers,
  sysOptions,
  ...
}: {
  imports = [
    ./audio.nix
    ./display_manager.nix
    ./fonts.nix
    # ./hyprland.nix
    ./niri.nix
    ./network.nix
    ./programs.nix
    ./shell.nix
    ./usb.nix
    ./yubikey.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/configuration.nix
  ];

  environment.variables = {
    WALLPAPER = "${wallpapers}/${sysOptions.wallpaper}.png";
    WALLPAPERS_DIR = "${wallpapers}";
    PROTON_LOG = "1";
    PROTON_LOG_DIR = "/home/maj/";

    NIXOS_OZONE_WL = "1";

    MOZ_ENABLE_WAYLAND = "1";

    GTK_CSD = "0";
    GTK_USE_PORTAL = "1";

    DISCORD_SKIP_HOST_GPU_BLOCKLIST = "1";
  };

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
  users.defaultUserShell = pkgs.nushell;

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

    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_DESKTOP = "Hyprland";
    # XDG_SESSION_TYPE = "wayland";
  };
}
