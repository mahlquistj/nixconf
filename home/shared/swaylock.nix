{
  wallpapers,
  sysOptions,
  ...
}: {
  programs.swaylock = {
    enable = true;
    settings = {
      image = "${wallpapers}/${sysOptions.wallpaper}.png";
    };
  };
}
