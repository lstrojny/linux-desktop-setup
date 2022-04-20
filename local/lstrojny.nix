{ nix-colors, ... }: {
  imports =
    [ nix-colors.homeManagerModule ./git.nix ./bash.nix ./vim.nix ./gnome-terminal.nix ./alacritty.nix ./tmux.nix ];

  home.keyboard = {
    layout = "de";
    variant = "nodeadkeys";
  };
}
