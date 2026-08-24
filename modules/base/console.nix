{ pkgs, config, ... }:

let
  col = config.ozozka.theme.colors;
in
{
  imports = [ ../theme.nix ];

  console = {
    enable = true;
    earlySetup = true;
    useXkbConfig = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];

    colors = [
      col.tokens.ansi0
      col.tokens.ansi1
      col.tokens.ansi2
      col.tokens.ansi3
      col.tokens.ansi4
      col.tokens.ansi5
      col.tokens.ansi6
      col.tokens.ansi7

      col.tokens.ansi8
      col.tokens.ansi9
      col.tokens.ansiA
      col.tokens.ansiB
      col.tokens.ansiC
      col.tokens.ansiD
      col.tokens.ansiE
      col.tokens.ansiF
    ];
  };
}
