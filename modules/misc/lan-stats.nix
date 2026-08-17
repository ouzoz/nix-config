{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.misc;
in
{
  options.my.misc.lan-stats.enable = lib.mkEnableOption "Language Stats";

  config = lib.mkIf cfg.lan-stats.enable {
    environment = {
      systemPackages = with pkgs; [
        scc
        github-linguist
      ];
      shellAliases = {
        lan = "scc -s lines --no-size --no-cocomo && github-linguist";
        land = "scc -s lines -a -p --sloccount-format && github-linguist";
        lanf = "scc -s lines -a -p --sloccount-format --by-file && github-linguist";
      };
    };
  };
}
