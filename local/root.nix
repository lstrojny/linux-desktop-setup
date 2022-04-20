{ nix-colors, ... }: { imports = [ nix-colors.homeManagerModule ./git.nix ./bash.nix ./vim.nix ./tmux.nix ]; }
