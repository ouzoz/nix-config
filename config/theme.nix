let
  themes = {
    dark = {
      var = "dark";

      p1 = "03aa95"; # oklch(0.66 0.1194 180)
      p2 = "026f61"; # oklch(0.486 0.0876 180)
      p3 = "10352f"; # oklch(0.3 0.0432 180)

      s1 = "ff3c5b"; # oklch(0.66 0.228 18)
      s2 = "c30d3a"; # oklch(0.522 0.204 18)
      s3 = "54121b"; # oklch(0.3 0.096 18)

      n1 = "ffffff"; # oklch(1 0.0042 180)
      n2 = "e4e8e7"; # oklch(0.928 0.0042 180)
      n3 = "929695"; # oklch(0.6696 0.0042 180)
      n4 = "565a59"; # oklch(0.4632 0.0042 180)
      n5 = "181a1a"; # oklch(0.216 0.0042 180)
      n6 = "000000"; # oklch(0 0.0042 180)

      t1 = "e0"; # 88%
      t2 = "f0"; # 94%

      # t0 = "0";
      # t1 = "233";
      # t2 = "235";
      # t3 = "239";
      # t4 = "246";
      # t5 = "15";
      # t6 = "1";
      # t7 = "3";
      # t8 = "2";
      # t9 = "5";
      # t10 = "6";
      # t11 = "4";
    };
  };
in
{
  theme = themes.dark;

  fonts = {
    sans = "Mona Sans";
    serif = "Spectral";
    mono = "Oziosevka";
  };
}
