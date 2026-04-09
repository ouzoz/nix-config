{
  description = "empty flake template";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; };
  outputs = { self, nixpkgs }:
  let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
  in {
    devShells = forAllSystems (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
        my-texlive = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic
            collection-fontsrecommended
            collection-latexextra
            collection-xetex

            latexmk
            biber;
          };
      in
      {
        default = pkgs.mkShell {
          packages = with pkgs; [
              my-texlive
              graphviz
              plantuml
          ];

          shellHook = ''
            echo "Project Packages and environment loaded for ${system}."
          '';
        };
      }
    );
  };
}
