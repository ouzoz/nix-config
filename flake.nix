{
  description = "ouz system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      ouz = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/ouz/configuration.nix ];
      };
    };

    templates = {
      empty.path = ./templates/empty;
      python.path = ./templates/python;
      rust.path = ./templates/rust;
      typescript.path = ./templates/typescript;
      cpp.path = ./templates/cpp;
      tex.path = ./templates/tex;
    };
  };
}
