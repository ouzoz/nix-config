{
  description = "nixos system config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      perSystem =
        f:
        nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (
          system: f (import nixpkgs { inherit system; })
        );
    in
    rec {
      formatter = perSystem (pkgs: pkgs.callPackage ./formatter.nix { });
      checks = perSystem (pkgs: pkgs.callPackages ./checks.nix { inherit inputs; });
      devShells = perSystem (pkgs: pkgs.callPackages ./devshells.nix { });
      apps = perSystem (pkgs: import ./apps.nix { inherit pkgs; });
      packages = perSystem (pkgs: import ./pkgs { inherit pkgs; });

      lib = import ./lib.nix { inherit (nixpkgs) lib; };
      templates = import ./templates;
      overlays = import ./overlays;
      nixosModules = lib.paths ./modules (path: path);
      nixosConfigurations = lib.paths ./hosts (path: import path { inherit inputs; });
    };
}
