{
  sysOptions,
  pkgs,
  ...
}: {
  programs = {
    yazi.enableNushellIntegration = true;
    starship.enableNushellIntegration = true;
    direnv.enableNushellIntegration = true;
    rio.settings.shell = {
      program = "nu";
      args = ["--login"];
    };
  };

  # Carapace, since nushell completions for git and alike aren't great
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;

    loginFile.text = ''
      # Set up SSH agent environment variables
      $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/gnupg/S.gpg-agent.ssh"
      $env.SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass"
    '';

    configFile.text = ''
      $env.config.show_banner = false

      # Ensure SSH agent environment variables are set (fallback)
      if ($env.SSH_AUTH_SOCK? | is-empty) {
          $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/gnupg/S.gpg-agent.ssh"
      }
      if ($env.SSH_ASKPASS? | is-empty) {
          $env.SSH_ASKPASS = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass"
      }

      def dirsize [dir?: path] {
          let p = $dir | default $env.PWD
          du $p | select apparent physical | math sum
      }

      # Delete local branches that don't exist on a remote.
      # Default: safe (-d), interactive confirmation.
      export def clean-git-branches [
          --remote (-r): string = "origin",  # which remote to compare against
          --force (-f),                      # force delete (-D), even if unmerged
          --yes   (-y),                      # skip confirmation prompt
      ] {
          # Ensure we're inside a git repo
          let inside = ( ^git rev-parse --is-inside-work-tree | str trim )
          if $inside != "true" {
              error make --unspanned { msg: "Not inside a git repository." }
          }

          # Update remote refs and prune deleted branches on the remote
          ^git fetch --all --prune

          # Determine current branch (may be empty on detached HEAD)
          let current = (try { ^git symbolic-ref --quiet --short HEAD | str trim } catch { "" })

          # All local branches
          let locals = (
              ^git for-each-ref --format="%(refname:short)" refs/heads
              | lines
              | str trim
              | where { |b| $b != "" }
          )

          # Remote branches for the chosen remote (strip "<remote>/")
          let remotes = (
              ^git for-each-ref --format="%(refname:short)" $"refs/remotes/($remote)"
              | lines
              | str trim
              | where { |b| $b != "" }
              | each { |b| $b | str replace -r $"^($remote)/" "" }
              | uniq
          )

          # Local-only branches (exclude current branch if known)
          let stale = (
              $locals
              | where { |b| ($remotes | any { |r| $r == $b }) == false }
              | where { |b| ($current == "" ) or ($b != $current) }
          )

          if ($stale | is-empty) {
              print $"No local branches are missing from remote '($remote)'. Nothing to delete."
              return
          }

          # Interactive confirmation unless --yes
          print $"The following local branches are not on '($remote)' and will be deleted:"
          $stale | each { |b| print $"  - ($b)" }

          if not $yes {
              let reply = (input "Proceed? [y/N]: " | str trim | str downcase)
              if not ($reply in ["y", "yes"]) {
                  print "Aborted. Nothing deleted."
                  return
              }
          }

          # Delete (safe -d by default; -f switches to -D)
          print $"Deleting local branches \(current: '($current | default "<detached>")'\)..."
          for b in $stale {
              if $force {
                  ^git branch -D $b
              } else {
                  ^git branch -d $b
              }
          }
          print "Done."
      }
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
