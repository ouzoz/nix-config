{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Oziosevka:size=12";
        # line-height = 18.6;
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
        cursor = "000000 ffffff";
        selection-foreground = "ffffff";
        selection-background = "ece6f1";
        foreground = "ffffff";
        background = "000000";

        # regular0 = "000000";
        # regular1 = "ea1d3b";
        # regular2 = "009e00";
        # regular3 = "888600";
        # regular4 = "5675eb";
        # regular5 = "ab41eb";
        # regular6 = "009689";
        # regular7 = "cbc6d0";
        #
        # bright0 = "65616a";
        # bright1 = "ea1d3b";
        # bright2 = "009e00";
        # bright3 = "888600";
        # bright4 = "5675eb";
        # bright5 = "ab41eb";
        # bright6 = "009689";
        # bright7 = "ffffff";


        regular0 = "000000";
        regular1 = "ff3a4c";
        regular2 = "00ea45";
        regular3 = "9c9b00";
        regular4 = "6687ff";
        regular5 = "bd56ff";
        regular6 = "40e0d0";
        regular7 = "cbc6d0";

        bright0 = "65616a";
        bright1 = "ff3a4c";
        bright2 = "00ea45";
        bright3 = "9c9b00";
        bright4 = "6687ff";
        bright5 = "bd56ff";
        bright6 = "40e0d0";
        bright7 = "ffffff";


        "233" = "100d14";
        "235" = "232027";
        "239" = "4e4a53";

        "241" = "65616a";
        "246" = "96929b";
        "251" = "ece6f1";
        "254" = "f7f2fc";
      };
      csd = {
        preferred = "none";
        # hide-when-maximized = "yes";
      };
    };
  };
}
