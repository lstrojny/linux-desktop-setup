{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.hackstrojny = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = attrs // { settings = (import ./settings.nix); };
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          system.configurationRevision = if self ? rev then self.rev else throw "Refusing to build from dirty git tree";
        })
        home-manager.nixosModules.home-manager
        ({ pkgs, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.lstrojny.imports = [ ./local/lstrojny.nix ];
          home-manager.users.root.imports = [ ./local/root.nix ];
        })
      ];
    };
  };
}
