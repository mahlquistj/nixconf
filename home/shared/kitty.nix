{sysOptions, ...}: {
  programs.kitty = {
    enable = true;

    # Ported from ./alacritty.nix
    #
    #   alacritty                    ->  kitty
    #   ---------------------------------------------------------------
    #   font.size                    ->  font_size
    #   font.normal/bold/italic      ->  font_family/bold_font/...
    #   cursor.style.shape           ->  cursor_shape
    #   cursor.style.blinking = "On" ->  cursor_blink_interval +
    #                                    cursor_stop_blinking_after = 0
    #   window.opacity               ->  background_opacity
    #   window.decorations = "none"  ->  hide_window_decorations
    #   window.padding.{x,y}         ->  window_padding_width
    #   window.dynamic_title         ->  (always on in kitty, no option)
    #   scrolling.history            ->  scrollback_lines
    #   scrolling.multiplier         ->  wheel_scroll_multiplier
    #   mouse.hide_when_typing       ->  mouse_hide_wait = -1
    #   keys: SpawnNewInstance       ->  new_os_window_with_cwd
    #   keys: Quit                   ->  quit
    #   keys: ToggleViMode           ->  (dropped, kitty has no vim mode)

    settings = {
      # Fonts
      font_size = 14.0;
      font_family = ''family="SauceCodePro Nerd Font Mono" style="Regular"'';
      bold_font = ''family="SauceCodePro Nerd Font Mono" style="Bold"'';
      italic_font = ''family="SauceCodePro Nerd Font Mono" style="Italic"'';
      bold_italic_font = ''family="SauceCodePro Nerd Font Mono" style="Bold Italic"'';

      # Cursor: block that keeps blinking
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 0.7;
      cursor_stop_blinking_after = 0.0;

      # Window
      background_opacity = 0.8;
      hide_window_decorations = true;
      window_padding_width = 10;
      placement_strategy = "top-left";

      # Scrolling
      scrollback_lines = 10000;
      wheel_scroll_multiplier = 1.0;

      # Mouse: hide the pointer as soon as you type
      mouse_hide_wait = -1.0;
    };

    keybindings = {
      "ctrl+alt+shift+t" = "new_os_window_with_cwd";
      "ctrl+alt+shift+q" = "quit";
    };

    extraConfig = ''
      # NOTE: kitty has no equivalent of alacritty's ToggleViMode. If we ever
      # want vim-ish scrolling, look at `scrollback_pager` or a custom kitten.
    '';
  };
}
