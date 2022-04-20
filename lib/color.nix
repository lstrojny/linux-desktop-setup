with builtins;
let
  map = {
    foreground = "base05";
    background = "base00";
    bright = {
      black = "base00";
      red = "base09";
      green = "base02";
      yellow = "base03";
      blue = "base04";
      magenta = "base0E";
      cyan = "base05";
      white = "base07";
    };
    normal = {
      black = "base01";
      red = "base08";
      green = "base0B";
      yellow = "base0A";
      blue = "base0D";
      magenta = "base0F";
      cyan = "base0C";
      white = "base06";
    };
  };

  mkColorMapFn = key: format: scheme: (format scheme.colors."${key}");
  mkColorMap = m: format:
    mapAttrs (color: key: if isAttrs key then mkColorMap key format else mkColorMapFn key format) m;

in {
  color = {
    names = [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ];
    lookup = {
      hex = {
        hashPrefix = mkColorMap map (s: "#" + s);
        zeroPrefix = mkColorMap map (s: "0x" + s);
        noPrefix = mkColorMap map (s: s);
      };
    };
  };
}
