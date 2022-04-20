{ nix-colors }: rec {
  identity = {
    nick = "lstrojny";
    name = "Lars Strojny";
    email = "lars@strojny.net";
  };

  buffersize = 10000;

  colorscheme = nix-colors.colorSchemes.solarized-dark // { kind = "dark"; };

  terminal = {
    rows = 60;
    columns = 120;
  };
}
