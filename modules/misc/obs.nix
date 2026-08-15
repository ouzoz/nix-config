{ config, lib, ... }:

let
  cfg = config.my.misc;
in
{
  options.my.misc.obs.enable = lib.mkEnableOption "obs studio";

  config = lib.mkIf cfg.obs.enable { programs.obs-studio.enable = true; };
}
