{pkgs, ...}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      bookmarks = [
        {
          name = "toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "Nix";
              bookmarks = [
                {
                  name = "Homepage";
                  tags = ["nix"];
                  url = "https://nixos.org";
                }
                {
                  name = "Packages";
                  tags = ["nix"];
                  keyword = "pkgs";
                  url = "https://search.nixos.org/packages";
                }
                {
                  name = "Options";
                  tags = ["nix"];
                  keyword = "options";
                  url = "https://search.nixos.org/options?";
                }
                {
                  name = "Home manager";
                  tags = ["nix"];
                  keyword = "hmoptions";
                  url = "https://home-manager-options.extranix.com/";
                }
                {
                  name = "Hydra";
                  tags = ["nix"];
                  url = "https://hydra.nixos.org/";
                }
                {
                  name = "Track PR";
                  tags = ["nix"];
                  url = "https://nixpk.gs/pr-tracker.html";
                }
              ];
            }
          ];
        }
        {
          name = "Github";
          tags = ["coding" "git"];
          url = "https://github.com";
          keyword = "gh";
        }
      ];
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        clearurls
        decentraleyes
        dashlane
        no-pdf-download
        tridactyl
        ublock-origin
      ];

      settings = {
        "gfx.webrender.all" = true; # Force GPU acceleration
        "reader.parse-on-load.force-enabled" = true;
        "privacy.webrtc.legacyGlobalIndicator" = false;

        "app.update.auto" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "strict";
        "browser.quitShortcut.disabled" = true;
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
      };
    };
  };
}
