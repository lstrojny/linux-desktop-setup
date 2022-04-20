{ settings, ... }:
with (import ../lib/color.nix);
with builtins; {
  programs.gnome-terminal = {
    enable = true;
    profile."55797305-f4de-4ca9-b990-4b53a46d3e1f" = {
      visibleName = "lstrojny";
      default = true;
      allowBold = true;
      audibleBell = false;
      colors = with settings;
        with color.lookup.hex.hashPrefix; {
          backgroundColor = background colorscheme;
          foregroundColor = foreground colorscheme;
          palette = (map (c: (normal."${c}" colorscheme)) color.names)
            ++ (map (c: (bright."${c}" colorscheme)) color.names);
        };
      cursorBlinkMode = "off";
      cursorShape = "ibeam";
      scrollbackLines = settings.buffersize;
    };

    themeVariant = settings.colorscheme.kind;
  };
}
