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

      (google-fonts.override {
        fonts = [
          "Manuale"
        ];
      })

      my.pkgs.oziosevka
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
