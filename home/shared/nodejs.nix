{pkgs, ...}: {
  home = {
    packages = [pkgs.nodejs];
    file.".npmrc" = {
      force = true;
      text = ''
        prefix=~/.npm-dir
      '';
    };
    sessionPath = [
      "$HOME/.npm-dir/bin"
    ];
  };
}
