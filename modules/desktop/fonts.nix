{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    source-sans
    corefonts
  ];
}
