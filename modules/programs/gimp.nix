{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.my.mod.programs;
in
{
  options.my.mod.programs = {
    gimp.enable = lib.mkEnableOption "gimp editor";
  };

  config = lib.mkIf cfg.gimp.enable { environment.systemPackages = with pkgs; [ gimp ]; };
}
