{pkgs, ...}: {
  home.packages = [pkgs.nodejs];
  home.file.".npmrc" = {
    force = true;
    text = ''
      prefix=~/.npm-dir
    '';
  };
}
