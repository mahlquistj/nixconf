{pkgs, ...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
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
