{ nix-colors, ... }: {
  imports = [ nix-colors.homeManagerModule ./git.nix ./bash.nix ./vim.nix ./tmux.nix ];

  home.stateVersion = "21.11";
}
