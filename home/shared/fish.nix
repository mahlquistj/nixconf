{ ... }:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # ls -> eza
      "ls" = "eza -F --icons";
      "la" = "eza -laF --icons";
      "lg" = "eza -laF --icons --git --git-ignore";
      "lt" = "eza -laF --tree --icons";
      "lt1" = "eza -laF --tree --icons --level 1";
      "lt2" = "eza -laF --tree --icons --level 2";
      "lt3" = "eza -laF --tree --icons --level 3";
      "lt4" = "eza -laF --tree --icons --level 4";

      # Various program aliases
      "top" = "btop";
    };

    shellAbbrs = {
      # Cargo
      cb = "cargo build";
      cc = "cargo check";
      cr = "cargo run";

      # git
      pull = "git pull";
      fetch = "git fetch";

      # nix
      ncg = "nix-collect-garbage";
      nhs = "home-manager switch";
      nrs = "sudo nixos-rebuild switch";
    };
  };
}
