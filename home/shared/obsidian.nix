{pkgs, ...}: {
  programs.obsidian = {
    enable = true;
    vaults = {
      notes = {};
    };
    defaultSettings = {
      app = {
        vimMode = true;
      };
      themes = [(pkgs.callPackage ./themes/obsidian-catppuccin.nix {})];
      appearance = {
        cssTheme = "Catppuccin";
        theme = "obsidian";
        accentColor = "#fab387";
        interfaceFontFamily = "Source Code Pro";
        textFontFamily = "Source Code Pro";
        monospaceFontFamily = "Source Code Pro";
      };
      corePlugins = [
        "file-explorer"
        "global-search"
        "switcher"
        "graph"
        "backlink"
        "canvas"
        "outgoing-link"
        "tag-pane"
        "page-preview"
        "daily-notes"
        "templates"
        "note-composer"
        "command-palette"
        "editor-status"
        "bookmarks"
        "outline"
        "word-count"
        "sync"
      ];
    };
  };
}
