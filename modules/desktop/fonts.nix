{ pkgs, my, ... }:
{
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      # corefonts

      (google-fonts.override {
        fonts = [
          "Spectral"
        ];
      })

      my.pkgs.oziosevka
      source-code-pro

      # source-sans
      mona-sans

      # source-serif

      # crimson-pro
    ];
  };
}
