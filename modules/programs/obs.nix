{ config, lib, ... }:

let
  cfg = config.my.mod.applications;
in
{
  options.my.mod.applications = {
    obs.enable = lib.mkEnableOption "obs studio";
  };

  config = lib.mkIf cfg.obs.enable { programs.obs-studio.enable = true; };
}
