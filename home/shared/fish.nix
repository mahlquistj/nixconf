{ ... }:

{
  home.sessionVariables = {
    fish_prompt_pwd_dir_length = 3;
    fish_prompt_pwd_full_dirs = 2;
    fish_greeting = "";
  };

  programs.fish = {
    enable = true;

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";

      # ls -> eza
      "ls" = "eza -F --icons";
      "la" = "eza -laF --icons";
      "lt" = "la --tree";
      "lt2" = "lt --level 2";
      "lt3" = "lt --level 3";
      "lt4" = "lt --level 4";
      "lt5" = "lt --level 5";
      "lg" = "la --git --git-ignore";
      "lgt" = "lt --git --git-ignore";
      "lgt2" = "lt2 --git --git-ignore";
      "lgt3" = "lt3 --git --git-ignore";
      "lgt4" = "lt4 --git --git-ignore";
      "lgt5" = "lt5 --git --git-ignore";

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
