{ pkgs, my, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # corefonts

      my.pkgs.oziosevka
      # source-code-pro
      #
      # source-sans
      # source-serif
      #
      # crimson-pro
    ];
  };
}
