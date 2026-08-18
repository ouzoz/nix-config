{
  description = "nixos config";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      myLib = (pkgs.callPackage ./lib/modules.nix { self = myLib; }).call {
        dir = ./lib;
        act = path: pkgs.callPackage path { self = myLib; };
      };

      mkHost =
        hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs self;
            my.lib = myLib;
          };
          modules = myLib.modules.paths ./modules ++ [
            myLib.home
            hostModule
          ];
        };
    in
    {
      # overlays
      # nixosModules =
      # lib =

      formatter.${system} = pkgs.callPackage ./formatter.nix { };
      checks.${system} = pkgs.callPackages ./checks.nix { };
      devShells.${system} = pkgs.callPackages ./devshells.nix { };

      apps.${system} = import ./apps.nix { inherit pkgs; };
      packages.${system} = myLib.modules.call { dir = ./pkgs; };

      templates = import ./templates;

      nixosConfigurations = myLib.modules.call {
        dir = ./hosts;
        act = mkHost;
      };
    };
}
