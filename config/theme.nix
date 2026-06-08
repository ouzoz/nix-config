let
  themes = {
    dark = {
      var = "dark";

      s1 = "000000";
      s2 = "100d14";
      s3 = "232027";
      s4 = "4e4a53";
      s5 = "96929b";
      s6 = "ffffff";
      c1 = "ff3a4c";
      c2 = "cccb00";
      c3 = "00ea45";
      c4 = "40e0d0";
      c5 = "6687ff";
      c6 = "bd56ff";

      t0 = "0";
      t1 = "233";
      t2 = "235";
      t3 = "239";
      t4 = "246";
      t5 = "15";
      t6 = "1";
      t7 = "3";
      t8 = "2";
      t9 = "5";
      t10 = "6";
      t11 = "4";
    };
  };
in
{
  theme = themes.dark;

  fonts = {
    main = "JetBrainsMono Nerd Font";
  };
}
