{ pkgs }:
{
  treesitter-runtime = pkgs.callPackage ./treesitter-runtime { };
  oziosevka = pkgs.callPackage ./oziosevka { };
}
