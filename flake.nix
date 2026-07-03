{
  description = "ouz system config";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      myLib = (pkgs.callPackage ./lib/modules.nix { self = myLib; }).call {
        dir = ./lib;
        args = {
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
              pkgs = myLib.modules.call { dir = ./pkgs; };
              overlays = import ./overlays;
              assets = ./assets;
            };
          };
          modules =
            myLib.modules.paths ./hosts/${hostname}
            ++ myLib.modules.paths ./modules
            ++ myLib.modules.paths ./config;
        };
    in
    {
      templates = import ./templates;
      apps.${system} = import ./apps.nix { inherit pkgs; };
      formatter.${system} = pkgs.callPackage ./formatter.nix { };
      checks.${system} = pkgs.callPackages ./checks.nix { };
      devShells.${system} = pkgs.callPackages ./devshells.nix { };
      nixosConfigurations = {
        ouz = mkHost "ouz";
      };
    };
}
