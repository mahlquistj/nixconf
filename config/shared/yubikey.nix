{pkgs, ...}: {
  services = {
    udev = {
      packages = with pkgs; [
        yubikey-personalization
      ];
      extraRules = ''
        ACTION=="remove",\
         ENV{ID_FIDO_TOKEN}=="1",\
         ENV{ID_VENDOR_FROM_DATABASE}=="Yubico.com",\
         RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
      '';
    };
    pcscd.enable = false;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    yubioath-flutter
  ];
}
