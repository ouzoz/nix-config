{
  description = "ouz system flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      myLib =
        (import ./lib/modules.nix {
          inherit (nixpkgs) lib;
          self = myLib;
        }).act
          {
            dir = ./lib;
            args = {
              inherit (nixpkgs) lib;
              self = myLib;
            };
          };

      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            my = {
              lib = myLib;
              pkgs = import ./pkgs { inherit pkgs; };
              overlays = import ./overlays;
              assets = ./assets;
            };
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
          ]
          ++ myLib.modules.paths { dir = ./modules; }
          ++ myLib.modules.paths { dir = ./config; };
        };
    in
    {
      templates = import ./templates;
      devShells.${system} = import ./devshells.nix { inherit pkgs; };
      nixosConfigurations = {
        ouz = mkHost "ouz";
      };
    };
}
