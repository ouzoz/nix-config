{
  pkgs,
  my,
  config,
  ...
}:

let
  cfg = config.my.theme.fonts;
in
{
  fonts = {
    enableDefaultPackages = false;
    # enableGhostscriptFonts = false;
    # fontDir.enable = false;

    packages = with pkgs; [
      noto-fonts-color-emoji
      # corefonts

      (google-fonts.override { fonts = [ "Spectral" ]; })

      my.pkgs.oziosevka
      source-code-pro

      source-sans
      mona-sans

      # crimson-pro
      source-serif
      eb-garamond
      libre-baskerville

    ];

    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
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
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
