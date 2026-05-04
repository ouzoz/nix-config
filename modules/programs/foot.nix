{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Oziosevka:size=14.4:style:medium";
        line-height = 18.6;
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
      mouse = {
        hide-when-typing = "yes";
      };
      colors-dark = {
        # alpha = ;
        cursor = "ffffff 000000";
        selection-foreground = "000000";
        selection-background = "232027";
        foreground = "000000";
        background = "ffffff";

        regular0 = "000000";
        regular1 = "ff3a4c";
        regular2 = "00b708";
        regular3 = "cccb00";
        regular4 = "6687ff";
        regular5 = "bd56ff";
        regular6 = "00ad9f";
        regular7 = "cbc6d0";

        bright0 = "65616a";
        bright1 = "ff3a4c";
        bright2 = "00b708";
        bright3 = "cccb00";
        bright4 = "6687ff";
        bright5 = "bd56ff";
        bright6 = "00ad9f";
        bright7 = "ffffff";

        "233" = "100d14";
        "235" = "232027";
        "239" = "4e4a53";
        "246" = "96929b";
      };
      csd = {
        preferred = "none";
        # hide-when-maximized = "yes";
      };
    };
  };
}
