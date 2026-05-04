{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    awscli2
    kubectl
    citrix_workspace
  ];

  programs = {
    docker-cli = {
      enable = true;
      settings = {
        "credsStore" = "ecr-login";
      };
    };
    nushell.shellAliases = {
      kb = "kubectl";
    };
    niri.settings = {
      spawn-at-startup = [
        {command = ["kanshi"];}
      ];
    };
  };

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
            criteria = "DP-2";
            scale = 1.0;
            mode = "3440x1440@100.00Hz";
          };
        }
        {
          profile = {
            name = "docked-work";
            outputs = [
              {
                criteria = "DP-2";
                status = "enable";
                position = "0,0";
              }
              {
                criteria = "eDP-1";
                status = "disable";
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
