{ pkgs, my, ... }:
{
  fonts.packages = with pkgs; [
    my.pkgs.oziosevka

    source-sans
    source-serif
    corefonts
  ];
}
