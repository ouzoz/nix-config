{
  self,
  pkgs,
  config,
  ...
}:

let
  cfg = config.my.theme.fonts;
  customPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
in
{
  fonts = {
    enableDefaultPackages = false;
    # enableGhostscriptFonts = false;
    # fontDir.enable = false;

    packages = with pkgs; [
      noto-fonts-color-emoji
      # corefonts

      customPackages.spectral
      customPackages.manuale
      customPackages.oziosevka
      source-sans
      inter
    ];

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = false;
      antialias = true;

      hinting = {
        enable = true;
        autohint = false;
        style = "slight";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };

      defaultFonts = {
        serif = [ cfg.serif ];
        sansSerif = [ cfg.sans ];
        monospace = [ cfg.mono ];
        emoji = [ cfg.emoji ];
      };
    };
  };
}
