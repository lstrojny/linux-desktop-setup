{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.hackstrojny = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
