{ pkgs, ... }: {

  # TTY configuraton
  console = {
    font = with pkgs; "${powerline-fonts}/share/consolefonts/ter-powerline-v14n.psf.gz";
    packages = with pkgs; [ powerline-fonts ];
    keyMap = "de";
    earlySetup = true;
  };
  # KMS based TTY replacement
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      font-name=Fira Code Medium
      font-size=12
      xkb-layout=de
      xkb-variant=nodeadkeys
      palette=solarized
    '';
  };
}
