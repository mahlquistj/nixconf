{sysOptions, ...}: {
  programs = {
    yazi.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    direnv.enableNushellIntegration = true;
    rio.settings.shell = {
      program = "nu";
      args = [];
    };
  };

  # Carapace, since nushell completions for git and alike aren't great
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;

    configFile.text = ''
      $env.config.show_banner = false
    '';

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # Program aliases
      "top" = "btop";
      "sudo" = "/run/wrappers/bin/sudo";

      # Development
      "dev" = "nix develop . --command \"nu\"";

      # Nix
      "nrb" = "/run/wrappers/bin/sudo nixos-rebuild switch --flake /home/${sysOptions.user}/nixconf/#${sysOptions.name} --impure --upgrade";
    };
  };
}
