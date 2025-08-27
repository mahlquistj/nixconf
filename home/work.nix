{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    wireguard-tools
  ];

  services = {
    trayscale.enable = true;
    kanshi = {
      enable = true;
      systemdTarget = "hyprland-session.target";

      settings = [
        {
          output = {
            criteria = "eDP-1";
            scale = 1.0;
            mode = "1920x1200@60.00Hz";
          };
        }
        {
          output = {
            criteria = "AOC CU34V5C 1UJQBHA000611";
            scale = 1.0;
            mode = "3440x1440@100.00Hz";
          };
        }
        {
          profile = {
            name = "docked";

            outputs = [
              {
                criteria = "AOC CU34V5C 1UJQBHA000611";
                status = "enable";
                position = "0,0";
              }
              {
                criteria = "eDP-1";
                status = "enable";
                position = "3440,0";
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
  };
}
