{
  description = "ouz system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            my = {
              lib = import ./lib;
              pkgs = import ./pkgs { inherit pkgs; };
              overlays = import ./overlays;
              assets = ./assets;
            };
          };
          modules = [
            ./config
            ./modules
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
          ];
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
