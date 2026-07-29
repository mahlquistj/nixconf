{pkgs, ...}: {
  home.file.".vst3/yabridge/yabridge.toml" = {
    force = true;
    text = ''
      # Yabridge per-plugin configuration
      # See: https://github.com/robbert-vdh/yabridge#configuration

      # ["Serum2.vst3"]
      # Default settings (editor_xembed = true) for proper mouse input
    '';
  };
}
