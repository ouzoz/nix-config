{ pkgs }:

let
  name = "system-flake";
  shellHook = ''
    echo "- ${name} ${name}-shell activated."
  '';
  packages = with pkgs; [
    lua-language-server

    nixfmt
    treefmt
    nixd

    zensical
    just
  ];
in
{
  default = pkgs.mkShell {
    inherit name packages;
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath packages;
    shellHook = ''
      echo "- ${name} shell activated."
    '';
  };
}
