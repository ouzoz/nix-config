_:

{
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
        alpha = 0.94;
        blur = true;
        cursor = "000000 ffffff";
        selection-foreground = "ffffff";
        selection-background = "4e4a53";
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
      };
      csd = {
        preferred = "none";
        # hide-when-maximized = "yes";
      };
    };
  };
}
