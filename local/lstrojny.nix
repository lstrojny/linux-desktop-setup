{ ... }: {
  imports = [ ./git.nix ./bash.nix ./vim.nix ./gnome-terminal.nix ];
  home.keyboard = {
    layout = "de";
    variant = "nodeadkeys";
  };
}
