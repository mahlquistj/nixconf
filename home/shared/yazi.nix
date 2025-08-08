{
  pkgs,
  sysOptions,
  ...
}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
  };

  xdg.portal = {
    config.common = {
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-termfilechooser
    ];
  };
  xdg.configFile = {
    # 1. Add the 'config' file
    "xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=/home/${sysOptions.user}/.config/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
        default_dir=$HOME
        ; Uncomment to skip creating destination save files with instructions in them
        ; create_help_file=0

        ; Mode must be one of 'suggested', 'default', or 'last'.
        open_mode=suggested
        save_mode=suggested
      '';
    };

    "xdg-desktop-portal-termfilechooser/yazi-wrapper.sh" = {
      force = true;
      source = ./yazi-wrapper.sh;
      executable = true;
    };
  };
}
