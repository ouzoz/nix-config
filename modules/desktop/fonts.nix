{ pkgs, config, ... }:

let
  cfg = config.ozozka.theme.fonts;
in
{
  imports = [ ../theme.nix ];

  fonts = {
    enableDefaultPackages = false;
    # enableGhostscriptFonts = false;
    # fontDir.enable = false;

    packages = with pkgs; [
      noto-fonts-color-emoji
      # corefonts

      ozozka.spectral
      ozozka.manuale
      ozozka.oziosevka
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
