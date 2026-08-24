{ config, ... }:

let
  col = config.ozozka.theme.colors;
in
{
  imports = [ ../theme.nix ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Oziosevka:size=12";
        line-height = 18;
        resize-delay-ms = 0;
        resize-keep-grid = "no";
        locked-title = "yes";
        selection-target = "clipboard";
        pad = "0x0";
      };
      scrollback = {
        lines = 0;
        indicator-position = "none";
      };
      cursor = {
        style = "block";
        beam-thickness = 1.2;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors-dark = {
        alpha = col.tokens.t0;
        blur = col.tokens.blur;
        cursor = "${col.tokens.b} ${col.tokens.f}";
        selection-foreground = col.tokens.f;
        selection-background = col.tokens.o;
        foreground = col.tokens.f;
        background = col.tokens.b;

        regular0 = col.tokens.ansi0;
        regular1 = col.tokens.ansi1;
        regular2 = col.tokens.ansi2;
        regular3 = col.tokens.ansi3;
        regular4 = col.tokens.ansi4;
        regular5 = col.tokens.ansi5;
        regular6 = col.tokens.ansi6;
        regular7 = col.tokens.ansi7;

        bright0 = col.tokens.ansi8;
        bright1 = col.tokens.ansi9;
        bright2 = col.tokens.ansiA;
        bright3 = col.tokens.ansiB;
        bright4 = col.tokens.ansiC;
        bright5 = col.tokens.ansiD;
        bright6 = col.tokens.ansiE;
        bright7 = col.tokens.ansiF;
      };
      csd = {
        preferred = "none";
        # hide-when-maximized = "yes";
      };
    };
  };
}
