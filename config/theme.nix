{ lib, config, ... }:

let
  cfg = config.my.theme;

  tokens = {
    dark = {
      primary = cfg.colors.palette.p1;
      primary-dim = cfg.colors.palette.p0;
      secondary = cfg.colors.palette.s1;
      secondary-dim = cfg.colors.palette.s0;
      foreground = cfg.colors.palette.n7;
      muted = cfg.colors.palette.n4;
      subtle = cfg.colors.palette.n3;
      overlay = cfg.colors.palette.n2;
      surface = cfg.colors.palette.n1;
      background = cfg.colors.palette.n0;

      ansi-primary = "14";
      ansi-primary-dim = "6";
      ansi-secondary = "9";
      ansi-secondary-dim = "1";
      ansi-foreground = "15";
      ansi-muted = "7";
      ansi-subtle = "8";
      ansi-overlay = "11";
      ansi-surface = "3";
      ansi-background = "0";
    };
    light = {
      primary = cfg.colors.palette.p0;
      primary-dim = cfg.colors.palette.p1;
      secondary = cfg.colors.palette.s0;
      secondary-dim = cfg.colors.palette.s1;
      foreground = cfg.colors.palette.n0;
      muted = cfg.colors.palette.n3;
      subtle = cfg.colors.palette.n4;
      overlay = cfg.colors.palette.n5;
      surface = cfg.colors.palette.n6;
      background = cfg.colors.palette.n7;

      ansi-primary = "6";
      ansi-primary-dim = "14";
      ansi-secondary = "1";
      ansi-secondary-dim = "9";
      ansi-foreground = "0";
      ansi-muted = "8";
      ansi-subtle = "7";
      ansi-overlay = "12";
      ansi-surface = "4";
      ansi-background = "15";
    };
  };
in
{
  options.my.theme = {
    colors = {
      variant = lib.mkOption {
        type = lib.types.enum (lib.attrNames tokens);
        default = "dark";
        description = "Color theme variant.";
      };
      palette = lib.mkOption {
        type = lib.types.attrs;
        default = rec {
          p1 = "03aa95"; # oklch(0.66 0.1194 180)
          p0 = "026f61"; # oklch(0.486 0.0876 180)
          s1 = "ff3c5b"; # oklch(0.66 0.228 18)
          s0 = "c30d3a"; # oklch(0.522 0.204 18)
          n7 = "ffffff"; # oklch(1 0.0042 180)
          n6 = "e4e8e7"; # oklch(0.928 0.0042 180)
          n5 = "d8dcdb"; # oklch(0.892 0.0042 180)
          n4 = "929695"; # oklch(0.6696 0.0042 180)
          n3 = "565a59"; # oklch(0.4632 0.0042 180)
          n2 = "1d201f"; # oklch(0.24 0.0042 180)
          n1 = "101212"; # oklch(0.18 0.0042 180)
          n0 = "000000"; # oklch(0 0.0042 180)

          ansi0 = n0;
          ansi1 = s0;
          ansi2 = p0;
          ansi3 = n1;
          ansi4 = n6;
          ansi5 = n2;
          ansi6 = p0;
          ansi7 = n4;

          ansi8 = n3;
          ansi9 = s1;
          ansiA = p1;
          ansiB = n2;
          ansiC = n5;
          ansiD = s1;
          ansiE = p1;
          ansiF = n7;

          t1 = "e0"; # 88%
          t0 = "f0"; # 94%
        };
        description = "Colors.";
      };
      tokens = lib.mkOption {
        type = lib.types.attrs;
        default = { };
        description = ''
          Color tokens. Defaults are selected according to my.theme.variant.
        '';
      };
    };

    spacing = {
      s = lib.mkOption {
        type = lib.types.int;
        default = 6;
        description = "Small spacing.";
      };
      m = lib.mkOption {
        type = lib.types.int;
        default = 12;
        description = "Medium spacing.";
      };
      l = lib.mkOption {
        type = lib.types.int;
        default = 30;
        description = "Large spacing.";
      };
    };

    fonts = {
      sans = lib.mkOption {
        type = lib.types.str;
        default = "Mona Sans";
        description = "Sans font.";
      };
      serif = lib.mkOption {
        type = lib.types.str;
        default = "Spectral";
        description = "Serif font.";
      };
      mono = lib.mkOption {
        type = lib.types.str;
        default = "Oziosevka";
        description = "Monospace font.";
      };
    };
  };

  config.my.theme.colors.tokens = lib.mkDefault tokens.${cfg.colors.variant};
}
