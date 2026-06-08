{ pkgs }:
{
  treesitter-runtime = pkgs.callPackage ./treesitter-runtime { inherit pkgs; };
  oziosevka = pkgs.callPackage ./oziosevka { };
}
