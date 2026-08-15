{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.my.misc;
in
{
  options.my.misc.gimp.enable = lib.mkEnableOption "gimp editor";

  config = lib.mkIf cfg.gimp.enable { environment.systemPackages = with pkgs; [ gimp ]; };
}
