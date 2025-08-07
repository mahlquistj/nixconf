{...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  xdg.configFile = {
    # 1. Add the 'config' file
    "xdg-desktop-portal-termfilechooser/config" = {
      # Use `text` for inline content.
      # Replace the content below with your actual config.
      text = ''
        [filechooser]
        cmd=yazi-wrapper.sh
        default_dir=$HOME
        ; Uncomment to skip creating destination save files with instructions in them
        ; create_help_file=0

        ; Mode must be one of 'suggested', 'default', or 'last'.
        open_mode=suggested
        save_mode=suggested
      '';
    };

    # 2. Add the 'yasi.sh' script and make it executable
    "xdg-desktop-portal-termfilechooser/yasi.sh" = {
      # Use `source` to point to your script file.
      # This assumes 'yasi.sh' is in the same directory as your home.nix.
      # Adjust the path if it's located elsewhere.
      source = ./yasi-wrapper.sh;

      # Set the executable bit
      executable = true;
    };
  };
}
