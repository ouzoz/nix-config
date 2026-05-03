{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Oziosevka:size=15";
        # line-height = 18;
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
        alpha = 0.92;
        cursor = "000000 ffffff";
        selection-foreground = "ffffff";
        selection-background = "232027";
        foreground = "ffffff";
        background = "000000";

        regular0 = "000000";
        regular1 = "ff3a4c";
        regular2 = "00ea45";
        regular3 = "cccb00";
        regular4 = "6687ff";
        regular5 = "bd56ff";
        regular6 = "40e0d0";
        regular7 = "cbc6d0";

        bright0 = "65616a";
        bright1 = "ff3a4c";
        bright2 = "00ea45";
        bright3 = "cccb00";
        bright4 = "6687ff";
        bright5 = "bd56ff";
        bright6 = "40e0d0";
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
