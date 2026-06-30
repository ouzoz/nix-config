{ lib, config, ... }:

let
  cfg = config.my.theme;

  tokens = {
    dark = rec {
      p = cfg.colors.palette.p1;
      s = cfg.colors.palette.s1;
      f = cfg.colors.palette.w;
      m = cfg.colors.palette.m;
      o = cfg.colors.palette.o1;
      b = cfg.colors.palette.b;

      ansi0 = b;
      ansi1 = s;
      ansi2 = p;
      ansi3 = p;
      ansi4 = s;
      ansi5 = s;
      ansi6 = p;
      ansi7 = m;
      ansi8 = o;
      ansi9 = s;
      ansiA = p;
      ansiB = p;
      ansiC = s;
      ansiD = s;
      ansiE = p;
      ansiF = f;

      ansi-primary = "6";
      ansi-secondary = "1";
      ansi-foreground = "15";
      ansi-muted = "7";
      ansi-overlay = "8";
      ansi-background = "0";

      t1 = 0.88;
      t0 = 0.94;
      hex-t1 = "e0"; # 88%
      hex-t0 = "f0"; # 94%

      blur = true;
    };
    light = rec {
      p = cfg.colors.palette.p0;
      s = cfg.colors.palette.s0;
      f = cfg.colors.palette.b;
      m = cfg.colors.palette.m;
      o = cfg.colors.palette.o0;
      b = cfg.colors.palette.w;

      ansi0 = b;
      ansi1 = s;
      ansi2 = p;
      ansi3 = p;
      ansi4 = s;
      ansi5 = s;
      ansi6 = p;
      ansi7 = m;
      ansi8 = o;
      ansi9 = s;
      ansiA = p;
      ansiB = p;
      ansiC = s;
      ansiD = s;
      ansiE = p;
      ansiF = f;

      ansi-primary = "6";
      ansi-secondary = "1";
      ansi-foreground = "15";
      ansi-muted = "7";
      ansi-overlay = "8";
      ansi-background = "0";

      t1 = 0.88;
      t0 = 0.94;
      hex-t1 = "e0"; # 88%
      hex-t0 = "f0"; # 94%

      blur = false;
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
        default = {
          p1 = "09bea8"; # oklch(0.72 0.1296 180)
          p0 = "026f61"; # oklch(0.486 0.0876 180)

          s1 = "ff3c5b"; # oklch(0.66 0.228 18)
          s0 = "c30d3a"; # oklch(0.522 0.204 18)

          w = "ffffff"; # oklch(1 0.0042 180)
          o0 = "e4e8e7"; # oklch(0.928 0.0042 180)
          m = "7e8180"; # oklch(0.60 0.0042 180)
          o1 = "101212"; # oklch(0.18 0.0042 180)
          b = "000000"; # oklch(0 0.0042 180)
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
