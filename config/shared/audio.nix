{pkgs, ...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;

    extraLadspaPackages = [
      pkgs.rnnoise-plugin
    ];

    extraConfig.pipewire."99-rnnoise-microphone" = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";

          args = {
            "node.description" = "Noise Suppressed Microphone";
            "media.name" = "Noise Suppressed Microphone";

            "filter.graph" = {
              nodes = [
                {
                  type = "ladspa";
                  name = "rnnoise";

                  # Because rnnoise-plugin is in extraLadspaPackages,
                  # PipeWire gets the correct LADSPA_PATH.
                  plugin = "librnnoise_ladspa";

                  label = "noise_suppressor_mono";

                  control = {
                    "VAD Threshold (%)" = 50.0;
                    "VAD Grace Period (ms)" = 200;
                    "Retroactive VAD Grace (ms)" = 0;
                  };
                }
              ];
            };

            "capture.props" = {
              "node.name" = "capture.rnnoise_source";
              "node.passive" = true;

              "audio.rate" = 48000;
              "audio.channels" = 1;
              "audio.position" = ["MONO"];

              "target.object" = "alsa_input.usb-Focusrite_Scarlett_2i2_4th_Gen_S2X3CBU512BB15-00.HiFi__Mic2__source";
            };

            "playback.props" = {
              "node.name" = "rnnoise_source";
              "node.description" = "Noise Suppressed Microphone";

              "media.class" = "Audio/Source";

              "audio.rate" = 48000;
              "audio.channels" = 1;
              "audio.position" = ["MONO"];
            };
          };
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol # General Audio GUI
    pulseaudio # Audio CLI controller
  ];

  # Allow audio group to lock memory and use realtime priority
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "256000";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "95";
    }
    {
      domain = "@audio";
      item = "nice";
      type = "-";
      value = "-11";
    }
  ];
}
