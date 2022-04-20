{ settings, ... }:
with (import ../lib/color.nix);
with builtins; {
  programs.alacritty = with settings; {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window = {
        dynamic_title = true;
        dimensions = {
          lines = terminal.rows;
          columns = terminal.columns;
        };
        gtk_theme_variant = colorscheme.kind;
      };
      cursor.style = "Beam";
      colors = with color.lookup.hex.hashPrefix; {
        primary = {
          background = background colorscheme;
          foreground = foreground colorscheme;

          normal = listToAttrs (map (c: {
            name = c;
            value = normal."${c}" colorscheme;
          }) color.names);

          bright = listToAttrs (map (c: {
            name = c;
            value = bright."${c}" colorscheme;
          }) color.names);
        };
      };
    };
  };
}
