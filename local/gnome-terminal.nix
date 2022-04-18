{ settings, ... }: {
  programs.gnome-terminal = {
    enable = true;
    profile."55797305-f4de-4ca9-b990-4b53a46d3e1f" = {
      visibleName = "lstrojny";
      default = true;
      allowBold = true;
      audibleBell = false;
      colors = {
        backgroundColor = "#002B36";
        foregroundColor = "#839496";
        palette = [
          "#073642"
          "#DC322F"
          "#859900"
          "#B58900"
          "#268BD2"
          "#D33682"
          "#2AA198"
          "#EEE8D5"
          "#002B36"
          "#CB4B16"
          "#586E75"
          "#657B83"
          "#839496"
          "#6C71C4"
          "#93A1A1"
          "#FDF6E3"
        ];
      };
      #colors.backgroundColor = null;
      cursorBlinkMode = "off";
      cursorShape = "ibeam";
      scrollbackLines = settings.buffersize;
    };

    themeVariant = settings.themeMode;
  };
}
