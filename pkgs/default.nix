{ pkgs }:
{
  treesitter-runtime = pkgs.callPackage ./treesitter-runtime { pkgs = pkgs; };
  oziosevka = pkgs.callPackage ./oziosevka { };
}
