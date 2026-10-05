{pkgs, ...}: {
  home = {
    packages = [pkgs.nodejs];
    file.".npmrc" = {
      force = true;
      text = ''
        prefix=''${HOME}/.npm-dir
      '';
    };
    sessionPath = [
      "$HOME/.npm-dir/bin"
    ];
  };
}
