{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    wireguard-tools
  ];

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        output = {
          criteria = "eDP-1";
          scale = 1.0;
        };
      }
      {
        output = {
          criteria = "ViewSonic Corporation VG2719-2K V4H212340447";
          scale = 1.0;
        };
      }
      {
        profile = {
          name = "docked";

          outputs = [
            {
              criteria = "ViewSonic Corporation VG2719-2K V4H212340447";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "enable";
              position = "2560,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "normal";
          outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        };
      }
    ];
  };
}
