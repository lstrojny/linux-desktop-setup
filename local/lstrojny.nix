{ nix-colors, pkgs, ... }:
let
  _1password-autostart = pkgs.makeAutostartItem {
    name = "1password";
    package = pkgs._1password-gui-beta;
  };
in {
  imports = [
    nix-colors.homeManagerModule
    ./git.nix
    ./bash.nix
    ./vim.nix
    ./gnome-terminal.nix
    ./alacritty.nix
    ./tmux.nix
    ./ssh.nix
  ];

  home.keyboard = {
    layout = "de";
    variant = "nodeadkeys";
  };

  home.packages = [ _1password-autostart ];

  home.stateVersion = "21.11";
}
