{ pkgs, ... }:
let
  oziosevka = pkgs.callPackage ../../packages/oziosevka { };
in
{
  fonts.packages = with pkgs; [
    oziosevka

    source-sans
    source-serif
    corefonts
  ];
}
