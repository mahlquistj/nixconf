{pkgs, ...}: {
  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];

  services.pcscd.enable = false;

  hardware.gpgSmartcards.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    yubioath-flutter
  ];
}
