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
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        ouz = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            vars = import ./vars;
          };
          modules = [ ./hosts/ouz/configuration.nix ];
        };
      };

      templates = import ./templates;

      devShells.${system} = import ./devshells.nix { inherit pkgs; };
    };
}
