{ config, lib, ... }:

let
  cfg = config.my.mod.programs;
in
{
  options.my.mod.programs = {
    obs.enable = lib.mkEnableOption "obs studio";
  };

  config = lib.mkIf cfg.obs.enable { programs.obs-studio.enable = true; };
}
