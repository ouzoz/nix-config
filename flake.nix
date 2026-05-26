{
  description = "ouz system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    name = "system-flake";

    pkgs-dev = with pkgs; [
      lua-language-server
      nixfmt-tree
      nixd

      zensical
      just
    ];

    shellHook = ''
      echo "- ${name} shell activated."
    '';

    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosConfigurations = {
      ouz = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/ouz/configuration.nix ];
      };
    };

    templates = import ./templates;

    devShells.${system} = {
      default = pkgs.mkShell {
        inherit name;
        inherit shellHook;
        packages = pkgs-dev;
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath pkgs-dev;
      };
    };
  };
}
