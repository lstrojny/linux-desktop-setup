# Linux desktop

Playground to set up a Linux desktop with nixOS

### Building the system
`sudo nixos-rebuild switch` will build the current state

`nix flake lock --update-input nixpkgs --commit-lock-file` update nixpkgs input

`nix flake lock --update-input home-manager --commit-lock-file` update home-manager input

### Queries
`nix search nixpkgs <expr>` search nix packages

`nix-env -f "<nixpkgs>" -qaP -A vimPlugins` show all vim plugin packages

### Configure hooks
Run `git config core.hooksPath hooks` to set up git hooks for autoformatting/checking
