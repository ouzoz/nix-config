{ config, pkgs, ... }:
# let
#   oziosevka = pkgs.callPackage ../../pkgs/oziosevka {};
# in
{
  fonts.packages = with pkgs; [
    # oziosevka

    source-sans
    corefonts
  ];
}
