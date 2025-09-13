{...}: {
  programs = {
    yazi.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    rio.settings.shell = {
      program = "nu";
      args = [];
    };
  };

  programs.nushell = {
    enable = true;

    configFile.text = ''
      $env.config.show_banner = false

      # Starship
      mkdir ($nu.data-dir | path join "vendor/autoload")
      starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
    '';

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # Various program aliases
      "top" = "btop";

      # Development
      "dev" = "nix develop . --command \"nu\"";
    };
  };
}
